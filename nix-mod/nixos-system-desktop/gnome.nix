{ pkgs, cfg, ... }:
{
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
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
  ]);
  home-manager.users.${cfg.opt.users.user.name} = {
    home.packages = with pkgs.gnomeExtensions; [
      paperwm
    ];
    dconf = {
      enable = true;
      settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = [
            "paperwm@paperwm.github.com"
          ];
        };
        "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      };
    };
  };
}
