{ config, lib, pkgs, ... }:

{
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri;
  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];
}
