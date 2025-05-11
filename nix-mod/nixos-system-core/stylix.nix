{ pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    polarity = "dark";
    fonts = {
      serif = {
        package = pkgs.source-han-serif;
        name = "Source Han Serif CN";
      };
      sansSerif = {
        package = pkgs.source-han-serif;
        name = "Source Han Sans CN";
      };
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
