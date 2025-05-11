{ lib, pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    settings = {
      background = lib.mkDefault "#1d2021";
      window-decoration = "none";
      maximize = "true";
      cursor-style = "underline";
    };
  };
}
