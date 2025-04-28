{ lib, pkgs, cfg, ... }:
{
  environment.systemPackages = with pkgs; [ helix wget curl ]
    ++ cfg.opt.system.packages;
  networking.hostName = cfg.sys.host;
  networking.networkmanager.enable = true;
  users.users = {
    root = {
      hashedPassword = if (cfg.opt.users.root.passwd != null) then cfg.opt.users.root.passwd else null;
      shell = if (cfg.opt.users.root.shell != null) then cfg.opt.users.root.shell else pkgs.bashInteractive;
    };
    ${cfg.opt.users.user.name} = {
      isNormalUser = true;
      name = cfg.opt.users.user.name;
      home = cfg.opt.users.user.home;
      hashedPassword = if (cfg.opt.users.user.passwd != null) then cfg.opt.users.user.passwd else null;
      extraGroups = cfg.opt.users.user.groups;
      shell = if (cfg.opt.users.user.shell != null) then cfg.opt.users.user.shell else pkgs.bashInteractive;
    };
  };
  system.stateVersion = if (cfg.opt.system.version != null) then cfg.opt.system.version else "25.05";
  system.autoUpgrade.channel = if (cfg.opt.system.channel != null) then cfg.opt.system.channel else null;
  boot.kernelPackages = if (cfg.opt.system.kernel != null) then cfg.opt.system.kernel else pkgs.linuxPackages_latest;
  services.displayManager.ly.enable = true;
  services.xserver.enable = true;
  programs.xwayland.enable = true;
  programs.dconf.enable = true;
  programs.git = {
    enable = true;
    package = pkgs.git;
  };
}
