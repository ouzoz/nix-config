{ pkgs, ... }:
{
  environment.shellAliases = {
    tok = "tokei -C -s lines";
    tokf = "tok -f";
    lin = "github-linguist";
    lan = "tok && lin";
  };
  environment.systemPackages = with pkgs; [
    tokei
    github-linguist
  ];
}
