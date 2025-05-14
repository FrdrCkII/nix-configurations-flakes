{
  lib,
  pkgs,
  cfg,
  ...
}:
{
  nixpkgs = {
    overlays = lib.mkIf (cfg.pkg.overlays != null) cfg.pkg.overlays;
    config = {
      allowUnfreePredicate = lib.mkIf (
        cfg.pkg.allowed-unfree-packages != null
      ) cfg.pkg.allowed-unfree-packages;
      permittedInsecurePackages = lib.mkIf (
        cfg.pkg.allowed-insecure-packages != null
      ) cfg.pkg.allowed-insecure-packages;
    };
  };
  nix = {
    package = pkgs.nix;
    settings = {
      cores = 0;
      max-jobs = "auto";
      sandbox = true;
      auto-optimise-store = true;
      builders-use-substitutes = true;
      extra-sandbox-paths = [
        "/dev"
        "/proc"
      ];
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
        "@root"
        "@nixwheel"
      ];
      allowed-users = [
        "root"
        "@root"
        "@nixwheel"
      ];
    };
    daemonIOSchedClass = "idle";
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedPriority = 0;
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
