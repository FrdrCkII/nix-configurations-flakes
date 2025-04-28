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
        settings = {

        };
      };
    };
  };
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      # 图标字体
      material-design-icons
      font-awesome

      noto-fonts # 大部分文字的常见样式，不包含汉字
      noto-fonts-cjk-sans # 汉字部分，由原来的noto-fonts-cjk拆成了两个包
      noto-fonts-cjk-serif
      noto-fonts-color-emoji # 彩色的表情符号字体，由noto-fonts-emoji重命名为noto-fonts-color-emoji

      source-sans # 无衬线字体，不含汉字。字族名叫 Source Sans 3 和 Source Sans Pro，以及带字重的变体，加上 Source Sans 3 VF
      source-serif # 衬线字体，不含汉字。字族名叫 Source Code Pro，以及带字重的变体
      source-han-sans # 思源黑体
      source-han-serif # 思源宋体

      # nerdfonts
      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable-small/pkgs/data/fonts/nerd-fonts/manifests/fonts.json
      nerd-fonts.symbols-only
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka

      wqy_microhei
      wqy_zenhei
      arphic-ukai
      arphic-uming
    ];
    fontconfig.enable = true;
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Source Han Serif CN" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Source Han Sans CN" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Sans Mono CJK SC" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
