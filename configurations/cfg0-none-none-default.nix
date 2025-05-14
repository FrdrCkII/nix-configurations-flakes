{
  lib,
  inputs,
  custom-lib,
}@custom-args:
{
  system = {
    name = lib.mkDefault null;
    host = lib.mkDefault null;
    config = lib.mkDefault null;
    system = lib.mkDefault null;
    type = lib.mkDefault null;
  };

  packages = {
    allowed-unfree-packages = lib.mkDefault null;
    allowed-insecure-packages = lib.mkDefault null;
    overlays = lib.mkDefault null;
  };

  nixos = {
    version = lib.mkDefault null;
    channel = lib.mkDefault null;
    kernel = lib.mkDefault null;
    passwd = lib.mkDefault null;
    shell = lib.mkDefault null;
    drivers = {
      amd = lib.mkDefault false;
      nvidia = lib.mkDefault false;
      intel = lib.mkDefault false;
    };
    boot = {
      loader = lib.mkDefault null;
      efi-mount-point = lib.mkDefault null;
    };
    packages = lib.mkDefault null;
    modules = lib.mkDefault null;
  };

  system-manager = {
    packages = lib.mkDefault null;
    modules = lib.mkDefault null;
  };

  home-manager = lib.mkDefault null;

}
