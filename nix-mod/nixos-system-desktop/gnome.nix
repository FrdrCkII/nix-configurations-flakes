{
  lib,
  pkgs,
  cfg,
  ...
}:
{
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (
    with pkgs;
    [
      atomix # puzzle game
      cheese # webcam tool
      epiphany # web browser
      evince # document viewer
      geary # email reader
      gedit # text editor
      gnome-characters
      gnome-music
      gnome-photos
      gnome-terminal
      gnome-tour
      hitori # sudoku game
      iagno # go game
      tali # poker game
      totem # video player
    ]
  );
  environment.systemPackages = with pkgs; [ gnomeExtensions.appindicator ];
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];
  home-manager.users = lib.foldl (
    acc: user:
    {
      ${user.name} = {
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
      };
    }
    // acc
  ) { } cfg.hom;
}
