{ lib, pkgs, ... }:
{
  programs.bat = {
    enable = true;
    package = pkgs.bat;
    config = {
      pager = "less -FR";
      theme = lib.mkDefault "catppuccin-mocha";
    };
  };
}
