{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fuzzel
  ];

  environment.etc."xdg/fuzzel/fuzzel.ini".text = ''
    [main]
    font=monospace:size=14
    terminal=alacritty -e # Replace with your preferred terminal
    prompt="> "
    icons-enabled=yes

    [colors]
    # Colors are in RGBA format (hex + alpha)
    background=282a36ff
    text=f8f8f2ff
    match=ff79c6ff
    selection=44475aff
    selection-text=f8f8f2ff
    selection-match=ff79c6ff
    border=bd93f9ff

    [border]
    width=2
    radius=10
  '';
}
