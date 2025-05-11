{ lib, pkgs, ... }:
{
  services.mako = {
    enable = true;
    package = pkgs.mako;
    settings = lib.mkDefault {
      actions = "true";
      anchor = "top-right";
      background-color = "#1d2021";
      border-color = "#3c3836";
      height = "100";
      width = "300";
      icons = "true";
      ignore-timeout = "false";
      layer = "top";
      margin = "10";
      markup = "true";
    };
  };
}
