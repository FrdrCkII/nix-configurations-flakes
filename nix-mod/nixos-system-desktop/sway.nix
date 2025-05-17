{
  lib,
  pkgs,
  cfg,
  ...
}:
{
  programs.sway = {
    enable = true;
    package = pkgs.sway;
    xwayland.enable = true;
  };
  home-manager.users = lib.foldl (
    acc: user:
    {
      ${user.name} = {
        imports = map cfg.lib.relativeToRoot [
          "nix-mod/nixos-home-programs/fuzzel.nix"
          "nix-mod/nixos-home-programs/mako.nix"
          "nix-mod/nixos-home-programs/swaylock.nix"
          "nix-mod/nixos-home-programs/waybar.nix"
        ];
        home.packages = with pkgs; [ swaybg ];
        xdg.configFile."sway" = {
          source = cfg.lib.relativeToRoot "dotfiles/${cfg.sys.config}/sway";
          recursive = true;
        };
      };
    }
    // acc
  ) { } cfg.hom;
}
