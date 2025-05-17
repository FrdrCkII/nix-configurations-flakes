{ lib, pkgs, ... }:
{
  programs.eza = {
    enable = true;
    package = pkgs.eza;
    colors = lib.mkDefault "always";
    git = true;
  };
}
