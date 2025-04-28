{ pkgs, ... }:
{
  home.language = {
    base = "zh_CN.UTF-8";
    messages = "zh_CN.UTF-8";
  };
  home.packages = with pkgs; [
    # 图标字体
    material-design-icons
    font-awesome

    noto-fonts # 大部分文字的常见样式，不包含汉字
    noto-fonts-cjk-sans # 汉字部分，由原来的noto-fonts-cjk拆成了两个包
    noto-fonts-cjk-serif
    noto-fonts-color-emoji # 彩色的表情符号字体，由noto-fonts-emoji重命名为noto-fonts-color-emoji
    # noto-fonts-extra # 提供额外的字重和宽度变种 # 包已移除

    source-sans # 无衬线字体，不含汉字。字族名叫 Source Sans 3 和 Source Sans Pro，以及带字重的变体，加上 Source Sans 3 VF
    source-serif # 衬线字体，不含汉字。字族名叫 Source Code Pro，以及带字重的变体
    source-han-sans # 思源黑体
    source-han-serif # 思源宋体
    # source-han-mono # 等宽字体，大多数时候用不上

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
  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
    serif = ["Noto Serif" "Source Han Serif CN" "Noto Color Emoji"];
    sansSerif = ["Noto Sans" "Source Han Sans CN" "Noto Color Emoji"];
    monospace = ["JetBrainsMono Nerd Font" "Noto Sans Mono CJK SC" "Noto Color Emoji"];
    emoji = ["Noto Color Emoji"];
  };
}
