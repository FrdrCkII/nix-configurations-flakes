{ config, lib, pkgs, ... }:

{
  services.xserver.desktopManager.lxqt.enable = true;
  xdg.portal.lxqt.enable = true;
}
