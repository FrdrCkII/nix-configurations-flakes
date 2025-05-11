{ pkgs, ... }:
{
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
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-rime
          rime-zhwiki
        ];
        settings = { };
      };
    };
  };
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    enableGhostscriptFonts = true;
    packages =
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

        # nerdfonts
        # 可以单独安装特定的包
        # 请注意不同版本安装方法也不同 https://wiki.nixos.org/wiki/Fonts#Installing_specific_nerdfonts
        # 列表 https://github.com/NixOS/nixpkgs/blob/nixos-unstable-small/pkgs/data/fonts/nerd-fonts/manifests/fonts.json
        # nerd-fonts.symbols-only
        # nerd-fonts.fira-code
        # nerd-fonts.jetbrains-mono
        # nerd-fonts.iosevka
      ]
      # 安装全部nerdfonts
      ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
    fontconfig.enable = true;
    fontconfig.defaultFonts = {
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
