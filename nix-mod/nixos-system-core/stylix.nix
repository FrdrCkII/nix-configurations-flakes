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
  home-manager.users = lib.foldl (
    acc: user:
    {
      ${user.name}.imports = map cfg.lib.relativeToRoot [
        "nix-mod/nixos-home-core/gtkqt.nix"
      ];
    }
    // acc
  ) { } cfg.hom;
  # https://github.com/danth/stylix
  # https://stylix.danth.me/
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    polarity = "dark";
    fonts = {
      serif = {
        name = "Noto Serif CJK SC";
        package = pkgs.noto-fonts-cjk-serif;
      };
      sansSerif = {
        name = "Noto Sans CJK SC";
        package = pkgs.noto-fonts-cjk-sans;
      };
      monospace = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-emoji;
      };
    };
  };
}
