{ config, lib, pkgs, cfg, ... }:

{
  home.packages = with pkgs; [
    fuzzel
    waybar
  ];
  xdg.configFile."fuzzel" = {
    source = cfg.lib.relativeToRoot "dotfiles/${cfg.sys.config}/fuzzel";
    recursive = true;
  };
  xdg.configFile."waybar" = {
    source = cfg.lib.relativeToRoot "dotfiles/${cfg.sys.config}/waybar";
    recursive = true;
  };
  xdg.configFile."niri" = {
    source = cfg.lib.relativeToRoot "dotfiles/${cfg.sys.config}/niri";
    recursive = true;
  };
}
