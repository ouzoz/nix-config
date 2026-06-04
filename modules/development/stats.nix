{ pkgs, ... }:
let 
  tok_command = "tokei -C -s lines";
in
{
  environment.shellAliases = {
    lanf ="${tok_command} -f";
    lan = "${tok_command} && github-linguist";
  };
  environment.systemPackages = with pkgs; [
    tokei
    github-linguist
  ];
}
