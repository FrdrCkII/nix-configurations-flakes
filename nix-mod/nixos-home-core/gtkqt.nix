{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme.name = "Breeze-Dark";
    theme.package = pkgs.kdePackages.breeze-gtk;
    iconTheme.name = "Breeze-Dark";
    iconTheme.package = pkgs.kdePackages.breeze-gtk;
    cursorTheme.name = "breeze";
    cursorTheme.package = pkgs.kdePackages.breeze-gtk;
    gtk3.extraConfig = {
      gtk-im-module = "fcitx";
    };
    gtk4.extraConfig = {
      gtk-im-module = "fcitx";
    };
  };
  qt = {
    enable = true;
    style.name = "breeze";
    style.package = with pkgs; [
      kdePackages.breeze
      kdePackages.breeze-icons
    ];
  };
}
