{ pkgs, cfg, ... }:
{
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri;
  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];
  home-manager.users.${cfg.opt.users.user.name} = {
    home.packages = with pkgs; [
      fuzzel
      waybar
      pwvucontrol
      swww
    ];
    xdg.configFile."fuzzel" = {
      source = cfg.lib.relativeToRoot "dotfiles/${cfg.sys.config}/fuzzel";
      recursive = true;
    };
    xdg.configFile."lxqt/wayland" = {
      source = cfg.lib.relativeToRoot "dotfiles/${cfg.sys.config}/lxqt";
      recursive = true;
    };
  };
}
