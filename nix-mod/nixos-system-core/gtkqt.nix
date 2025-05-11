{
  lib,
  pkgs,
  cfg,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    qt6.qtwayland
    qt5.qtwayland
  ];
  home-manager.users.${cfg.opt.users.user.name} = {
    gtk = {
      enable = true;
      theme = {
        name = lib.mkDefault "Adwaita";
        package = lib.mkDefault pkgs.gnome-themes-extra;
      };
      iconTheme = {
        name = lib.mkDefault "Adwaita";
        package = lib.mkDefault pkgs.adwaita-icon-theme;
      };
      cursorTheme = {
        name = lib.mkDefault "Vanilla-DMZ";
        package = lib.mkDefault pkgs.vanilla-dmz;
        size = lib.mkDefault 16;
      };
      gtk2 = {
        configLocation = "${cfg.opt.users.user.home}/.config/gtk-2.0/gtkrc";
        extraConfig = '''';
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-im-module = "fcitx";
        gtk-toolbar-style = "GTK_TOOLBAR_BOTH";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
        gtk-button-images = 1;
        gtk-menu-images = 1;
        gtk-enable-event-sounds = 1;
        gtk-enable-input-feedback-sounds = 1;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintfull";
      };
      gtk4.extraConfig = {
        gtk-im-module = "fcitx";
      };
    };
    qt = {
      enable = true;
      platformTheme.name = lib.mkDefault "qtct";
      style = {
        name = lib.mkDefault "adwaita-dark";
        package =
          with pkgs;
          lib.mkDefault [
            adwaita-qt
            adwaita-qt6
          ];
      };
    };
    home.pointerCursor = {
      enable = true;
      name = lib.mkDefault "Vanilla-DMZ";
      package = lib.mkDefault pkgs.vanilla-dmz;
      size = lib.mkDefault 16;
      dotIcons.enable = true;
      gtk.enable = true;
      x11.enable = true;
      sway.enable = true;
    };
  };
}
