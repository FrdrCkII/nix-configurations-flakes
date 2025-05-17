{ cfg, ... }:
{
  imports = map cfg.lib.relativeToRoot [
    "nix-mod/nixos-home-programs/i18n/fonts.nix"
    "nix-mod/nixos-home-programs/i18n/fcitx5.nix"
  ];
  home.language = {
    base = "zh_CN.UTF-8";
    messages = "zh_CN.UTF-8";
  };
}
