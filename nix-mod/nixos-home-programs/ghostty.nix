{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    enableZshIntegration = true;
    clearDefaultKeybinds = false;
    settings = {
      background = "#323232";
      background-opacity = "0.8";
      background-blur = "true";
      window-decoration = "none";
      maximize = "true";
      cursor-style = "underline";
    };
  };
}
