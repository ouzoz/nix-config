{ lib, ... }:

{ config, ... }:

let
  inherit (builtins) attrNames;
  inherit (lib)
    all
    any
    attrValues
    concatLists
    concatMap
    filter
    filterAttrs
    foldl'
    hasAttr
    hasInfix
    hasPrefix
    head
    length
    listToAttrs
    mapAttrs
    mapAttrs'
    mapAttrsToList
    mkOption
    nameValuePair
    splitString
    tail
    types
    unique
    ;

  fileType = types.submodule {
    options = {
      source = mkOption {
        type = types.nullOr types.path;
        default = null;
        description = "Public, store-backed source file or directory. Do not use for secrets.";
      };

      text = mkOption {
        type = types.nullOr types.lines;
        default = null;
        description = "Public, generated file contents. Do not use for secrets.";
      };
    };
  };

  profileType = types.submodule {
    options.files = mkOption {
      type = types.attrsOf fileType;
      default = { };
      description = "Home-relative files supplied by this profile.";
    };
  };

  cfg = config.my.home;

  hasExactlyOneContent = file: (file.source != null) != (file.text != null);

  isSafeTmpfilesValue =
    value:
    all (character: !hasInfix character (toString value)) [
      "'"
      "%"
      "\\"
      "\n"
      "\r"
      "\t"
    ];

  isValidTarget =
    target:
    let
      components = splitString "/" target;
    in
    target != ""
    && !hasPrefix "/" target
    && all (component: component != "" && component != "." && component != "..") components
    && isSafeTmpfilesValue target;

  duplicateValues =
    values: unique (filter (value: length (filter (candidate: candidate == value) values) > 1) values);

  ancestorConflicts =
    targets:
    unique (
      concatMap (
        ancestor:
        map (descendant: "${ancestor} -> ${descendant}") (
          filter (descendant: descendant != ancestor && hasPrefix "${ancestor}/" descendant) targets
        )
      ) targets
    );

  parentTargets =
    target:
    let
      go =
        prefix: components:
        if length components <= 1 then
          [ ]
        else
          let
            next = if prefix == "" then head components else "${prefix}/${head components}";
          in
          [ next ] ++ go next (tail components);
    in
    go "" (splitString "/" target);

  declaredFiles = concatLists (
    mapAttrsToList (
      profileName: profile:
      mapAttrsToList (target: file: {
        context = "home profile '${profileName}'";
        inherit file target;
      }) profile.files
    ) cfg.profiles
  );

  enabledProfileNames = activations: attrNames (filterAttrs (_: enabled: enabled) activations);

  configuredUsers = filterAttrs (
    userName: activations:
    hasAttr userName config.users.users && any (enabled: enabled) (attrValues activations)
  ) cfg.users;

  resolveUser =
    userName: activations:
    let
      account = config.users.users.${userName};
      enabledProfiles = enabledProfileNames activations;
      knownProfiles = filter (profileName: hasAttr profileName cfg.profiles) enabledProfiles;
      fileSets = map (profileName: cfg.profiles.${profileName}.files) knownProfiles;
      targets = concatMap attrNames fileSets;
      mergedFiles = foldl' (files: profileFiles: files // profileFiles) { } fileSets;
      files = filterAttrs (target: file: isValidTarget target && hasExactlyOneContent file) mergedFiles;
    in
    {
      inherit
        account
        enabledProfiles
        files
        targets
        ;
    };

  resolvedUsers = mapAttrs resolveUser configuredUsers;

  fileAssertions = concatMap (declaration: [
    {
      assertion = isValidTarget declaration.target;
      message = "${declaration.context} has invalid target '${declaration.target}'. Targets must be safe relative paths without empty, '.' or '..' components.";
    }
    {
      assertion = hasExactlyOneContent declaration.file;
      message = "${declaration.context} target '${declaration.target}' must define exactly one of 'source' or 'text'.";
    }
  ]) declaredFiles;

  userReferenceAssertions = mapAttrsToList (userName: _: {
    assertion = hasAttr userName config.users.users;
    message = "Home configuration references unknown NixOS user '${userName}'.";
  }) cfg.users;

  resolvedUserAssertions = concatLists (
    mapAttrsToList (
      userName: resolved:
      let
        inherit (resolved) account enabledProfiles targets;
        unknownProfiles = filter (profileName: !hasAttr profileName cfg.profiles) enabledProfiles;
        duplicates = duplicateValues targets;
        conflicts = ancestorConflicts targets;
      in
      [
        {
          assertion = account.enable;
          message = "Home configuration for '${userName}' requires the NixOS user to be enabled.";
        }
        {
          assertion = account.isNormalUser;
          message = "Home configuration for '${userName}' is only supported for normal NixOS users.";
        }
        {
          assertion = account.createHome;
          message = "Home configuration for '${userName}' requires users.users.${userName}.createHome to be enabled.";
        }
        {
          assertion = isSafeTmpfilesValue account.home;
          message = "Home directory '${toString account.home}' for '${userName}' contains characters unsupported by this home manager.";
        }
        {
          assertion = unknownProfiles == [ ];
          message = "Home configuration for '${userName}' enables unknown profiles: ${toString unknownProfiles}.";
        }
        {
          assertion = duplicates == [ ];
          message = "Home configuration for '${userName}' contains duplicate targets: ${toString duplicates}.";
        }
        {
          assertion = conflicts == [ ];
          message = "Home configuration for '${userName}' contains parent/child target conflicts: ${toString conflicts}.";
        }
      ]
    ) resolvedUsers
  );

  resolvedHomes = mapAttrsToList (_: resolved: toString resolved.account.home) resolvedUsers;
  resolvedOwners = mapAttrsToList (_: resolved: resolved.account.name) resolvedUsers;
  duplicateHomes = duplicateValues resolvedHomes;
  overlappingHomes = ancestorConflicts resolvedHomes;
  duplicateOwners = duplicateValues resolvedOwners;

  crossUserAssertions = [
    {
      assertion = duplicateHomes == [ ];
      message = "Home configuration contains users with duplicate home directories: ${toString duplicateHomes}.";
    }
    {
      assertion = overlappingHomes == [ ];
      message = "Home configuration contains overlapping home directories: ${toString overlappingHomes}.";
    }
    {
      assertion = duplicateOwners == [ ];
      message = "Home configuration contains duplicate effective user names: ${toString duplicateOwners}.";
    }
  ];

  makeEtcEntries =
    _: resolved:
    mapAttrs' (
      target: file:
      nameValuePair "home-files/${resolved.account.name}/${target}" (
        if file.source != null then { inherit (file) source; } else { inherit (file) text; }
      )
    ) resolved.files;

  etcEntries = foldl' (entries: userEntries: entries // userEntries) { } (
    mapAttrsToList makeEtcEntries resolvedUsers
  );

  makeTmpfilesSettings =
    _: resolved:
    let
      inherit (resolved) account files;
      home = toString account.home;
      owner = account.name;
      parents = unique (concatMap parentTargets (attrNames files));

      parentRules = listToAttrs (
        map (
          parent:
          nameValuePair "${home}/${parent}" {
            d = {
              mode = ":0755";
              user = ":${owner}";
              group = ":${account.group}";
            };
          }
        ) parents
      );

      linkRules = mapAttrs' (
        target: _:
        nameValuePair "${home}/${target}" {
          L = {
            user = ":${owner}";
            group = ":${account.group}";
            argument = "/etc/home-files/${owner}/${target}";
          };
        }
      ) files;
    in
    nameValuePair "10-home-files-${owner}" (parentRules // linkRules);

  tmpfilesSettings = listToAttrs (mapAttrsToList makeTmpfilesSettings resolvedUsers);
in
{
  options.my.home = {
    profiles = mkOption {
      type = types.attrsOf profileType;
      default = { };
      description = "Reusable home configuration profiles.";
    };

    users = mkOption {
      type = types.attrsOf (types.attrsOf types.bool);
      default = { };
      description = "Home profiles enabled for each NixOS user.";
    };
  };

  config = {
    assertions =
      fileAssertions ++ userReferenceAssertions ++ resolvedUserAssertions ++ crossUserAssertions;
    environment.etc = etcEntries;
    systemd.tmpfiles.settings = tmpfilesSettings;
  };
}
