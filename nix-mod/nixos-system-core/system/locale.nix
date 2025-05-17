{ pkgs, cfg, ... }:
{
  imports = map cfg.lib.relativeToRoot [
    "nix-mod/nixos-system-programs/i18n/fonts.nix"
    "nix-mod/nixos-system-programs/i18n/fcitx5.nix"
  ];
  # 建议参考 https://wiki.archlinuxcn.org/wiki/简体中文本地化
  time.timeZone = "Asia/Shanghai";
  i18n = {
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
    defaultLocale = "zh_CN.UTF-8";
    extraLocaleSettings = {
      LANGUAGE = "zh_CN:en_US:en";
      LC_MESSAGES = "en_US.UTF-8";
    };
  };
}
