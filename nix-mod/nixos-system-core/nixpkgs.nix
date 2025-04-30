{ lib, pkgs, cfg, ... }:
{
  nixpkgs = {
    overlays = cfg.pkg.overlays;
    config = {
      allowUnfreePredicate = cfg.pkg.allowed-unfree-packages;
      permittedInsecurePackages = cfg.pkg.allowed-insecure-packages;
    };
  };
  nix = {
    package = pkgs.nix;
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = [
        "flakes"
        "nix-command"
        "ca-derivations"
      ];
      substituters = [
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://cache.nixos.org"
      ];
      trusted-substituters = [
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://cache.nixos.org"
      ];
      trusted-users = [
        "root"
        "@wheel"
        cfg.opt.users.user.name
      ];
    };
    gc = lib.mkDefault {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
    optimise.automatic = lib.mkDefault true;
    optimise.dates = lib.mkDefault [ "03:45" ];
  };
  boot.loader = {
    systemd-boot.configurationLimit = lib.mkDefault 10;
    grub.configurationLimit = lib.mkDefault 10;
  };
}
