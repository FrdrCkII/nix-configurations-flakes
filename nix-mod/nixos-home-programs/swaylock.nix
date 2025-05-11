{ lib, pkgs, ... }:
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock;
    settings = lib.mkDefault {
      color = "000000";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      line-color = "ffffff";
      show-failed-attempts = true;
    };
  };
}
