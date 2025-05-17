{ lib, pkgs, ... }:
{
  home.packages = with pkgs.gnomeExtensions; [
    paperwm
    kimpanel
    gamemode-shell-extension
  ];
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          paperwm.extensionUuid
          kimpanel.extensionUuid
          appindicator.extensionUuid
          gamemode-shell-extension.extensionUuid
        ];
      };
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };
  };
}
