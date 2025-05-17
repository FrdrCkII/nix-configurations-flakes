{ lib, pkgs, ... }:
{
  home.language = {
    base = "zh_CN.UTF-8";
    messages = "zh_CN.UTF-8";
  };
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
  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
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
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [ fcitx5-rime ];
      settings = {
        globalOptions = {
          Hotkey = {
            EnumerateWithTriggerKeys = "True";
            EnumerateSkipFirst = "False";
            ModifierOnlyKeyTimeout = "250";
          };
          "Hotkey/TriggerKeys" = {
            "0" = "Control+Tab";
          };

          "Hotkey/AltTriggerKeys" = {
            "0" = "Shift_L";
          };

          "Hotkey/EnumerateGroupForwardKeys" = {
            "0" = "Super+space";
          };

          "Hotkey/EnumerateGroupBackwardKeys" = {
            "0" = "Shift+Super+space";
          };

          "Hotkey/ActivateKeys" = {
            "0" = "Hangul_Hanja";

          };
          "Hotkey/DeactivateKeys" = {
            "0" = "Hangul_Romaja";
          };

          "Hotkey/PrevPage" = {
            "0" = "Up";
          };

          "Hotkey/NextPage" = {
            "0" = "Down";
          };

          "Hotkey/PrevCandidate" = {
            "0" = "Shift+Tab";
          };

          "Hotkey/NextCandidate" = {
            "0" = "Tab";
          };

          "Hotkey/TogglePreedit" = {
            "0" = "Control+Alt+P";
          };

          Behavior = {
            # Active By Default
            ActiveByDefault = "False";
            # Reset state on Focus In
            resetStateWhenFocusIn = "No";
            # Share Input State
            ShareInputState = "No";
            # Show preedit in application
            PreeditEnabledByDefault = "True";
            # Show Input Method Information when switch input method
            ShowInputMethodInformation = "True";
            # Show Input Method Information when changing focus
            showInputMethodInformationWhenFocusIn = "False";
            # Show compact input method information
            CompactInputMethodInformation = "True";
            # Show first input method information
            ShowFirstInputMethodInformation = "True";
            # Default page size
            DefaultPageSize = 5;
            # Override Xkb Option
            OverrideXkbOption = "False";
            # Preload input method to be used by default
            PreloadInputMethod = "True";
            # Allow input method in the password field
            AllowInputMethodForPassword = "False";
            # Show preedit text when typing password
            ShowPreeditForPassword = "False";
            # Interval of saving user data in minutes
            AutoSavePeriod = 30;
          };
        };
        addons = {
          classicui.globalSection = {
            PreferTextIcon = lib.mkDefault "True";
            Theme = lib.mkDefault "default-dark";
            UseDarkTheme = lib.mkDefault "False";
            UseAccentColor = lib.mkDefault "False";
          };
        };
      };
    };
  };
}
