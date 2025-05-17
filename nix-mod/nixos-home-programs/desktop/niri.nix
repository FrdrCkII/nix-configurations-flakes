{
  lib,
  pkgs,
  cfg,
  ...
}:
{
  imports = map cfg.lib.relativeToRoot [
    "nix-mod/nixos-home-programs/fuzzel.nix"
    "nix-mod/nixos-home-programs/ghostty.nix"
    "nix-mod/nixos-home-programs/mako.nix"
    "nix-mod/nixos-home-programs/swaylock.nix"
    "nix-mod/nixos-home-programs/waybar.nix"
  ];
  home.packages = with pkgs; [ swaybg ];
  xdg.configFile."niri" = {
    source = cfg.lib.relativeToRoot "dotfiles/${cfg.sys.config}/niri";
    recursive = true;
  };
}
