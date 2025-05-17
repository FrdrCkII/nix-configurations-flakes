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
        imports = map cfg.lib.relativeToRoot [
          "nix-mod/nixos-home-programs/desktop/gnome.nix"
        ];
      };
    }
    // acc
  ) { } cfg.hom;
}
