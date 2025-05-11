{ lib, pkgs, ... }:
{
  services.mako = {
    enable = true;
    package = pkgs.mako;
    settings = {
      actions = true;
      anchor = "top-right";
      background-color = lib.mkDefault "#1d2021";
      border-color = lib.mkDefault "#3c3836";
      height = 100;
      width = 300;
      icons = true;
      ignore-timeout = false;
      layer = "top";
      margin = 10;
      markup = true;
    };
  };
}
