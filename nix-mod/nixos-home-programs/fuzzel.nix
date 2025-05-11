{ lib, pkgs, ... }:
{
  programs.fuzzel = {
    enable = true;
    package = pkgs.fuzzel;
    settings = {
      # icons-enabled = false;
      # match-mode = "fzf";
      colors = lib.mkDefault {
        background = "000000ff";
        selection = "101010cc";
        border = "000000ff";
      };
    };
  };
}
