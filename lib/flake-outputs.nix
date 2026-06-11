{ importNixFiles, ... }:
{
  templatesFrom = importNixFiles;
  overlaysFrom = path: builtins.attrValues (importNixFiles path);
}
