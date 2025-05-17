{ lib, pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      material-design-icons
      font-awesome

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji

      source-sans
      source-serif
      source-han-sans
      source-han-serif

      wqy_microhei
      wqy_zenhei
      arphic-ukai
      arphic-uming
    ]
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [
        "Noto Serif"
        "Source Han Serif SC"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Noto Sans"
        "Source Han Sans SC"
        "Noto Color Emoji"
      ];
      monospace = [
        "JetBrainsMono Nerd Font"
        "Noto Sans Mono CJK SC"
        "Noto Color Emoji"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
