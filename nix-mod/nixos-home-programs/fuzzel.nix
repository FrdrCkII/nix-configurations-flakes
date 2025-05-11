{ lib, pkgs, ... }:
{
  programs.fuzzel = {
    enable = true;
    package = pkgs.fuzzel;
    settings = lib.mkDefault {
      icons-enabled = false;
      match-mode = "fzf";
      colors = {
        background = "000000ff";
        selection = "101010cc";
        border = "000000ff";
      };
    };
  };
}
