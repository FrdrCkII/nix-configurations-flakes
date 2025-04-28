{ pkgs, cfg, ... }:
{
  home.packages = with pkgs; [
    fastfetch
  ];
  xdg.configFile."fastfetch" = {
    source = cfg.lib.relativeToRoot "dotfiles/${cfg.sys.config}/fastfetch";
    recursive = true;
  };
}
