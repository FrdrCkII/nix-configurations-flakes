{ config, ... }:
{
  xdg = {
    enable = true;
    configHome = "${config.home.homeDirectory}/.config";
    userDirs = {
      enable = true;
      extraConfig = {
        XDG_DESKTOP_DIR = "${config.home.homeDirectory}/_desk";
        XDG_DOCUMENTS_DIR = "${config.home.homeDirectory}/_docx";
        XDG_DOWNLOAD_DIR = "${config.home.homeDirectory}/_down";
        XDG_MUSIC_DIR = "${config.home.homeDirectory}/_musc";
        XDG_PICTURES_DIR = "${config.home.homeDirectory}/_pict";
        XDG_PUBLICSHARE_DIR = "${config.home.homeDirectory}/_pubs";
        XDG_TEMPLATES_DIR = "${config.home.homeDirectory}/_temp";
        XDG_VIDEOS_DIR = "${config.home.homeDirectory}/_vide";
        XDG_MISC_DIR = "${config.home.homeDirectory}/_misc";
      };
    };
  };
}
