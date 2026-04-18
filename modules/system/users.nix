{ ... }:

{
  users.users.ouz = {
    isNormalUser = true;
    description = "ouz";
    extraGroups = [ "wheel" ];
  };
}
