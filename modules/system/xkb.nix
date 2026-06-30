{ config, ... }: { services.xserver.xkb = { inherit (config.my.xkb) layout options; }; }
