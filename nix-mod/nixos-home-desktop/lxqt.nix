{ pkgs, cfg, ... }:
{
  home.packages = with pkgs; [
    fuzzel
    pwvucontrol
  ];
  xdg.configFile."fuzzel" = {
    source = cfg.lib.relativeToRoot "dotfiles/${cfg.sys.config}/fuzzel";
    recursive = true;
  };
  xdg.configFile."lxqt/wayland" = {
    source = cfg.lib.relativeToRoot "dotfiles/${cfg.sys.config}/lxqt";
    recursive = true;
  };
}
