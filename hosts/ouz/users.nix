_:

{
  users.users.ouz = {
    isNormalUser = true;
    description = "ouz";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  my.home.users = {
    ouz = {
      emacs = true;
    };
  };
}
