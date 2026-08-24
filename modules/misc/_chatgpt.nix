{ pkgs, ... }:

{ environment.systemPackages = with pkgs; [ chatgpt ]; }
