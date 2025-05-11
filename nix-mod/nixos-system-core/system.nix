{
  lib,
  pkgs,
  cfg,
  ...
}:
{
  environment.systemPackages =
    with pkgs;
    [
      helix
      wget
      curl
      gcc
      clang
      perl
      llvmPackages_latest.bintools
    ]
    ++ cfg.opt.system.packages;
  networking = {
    hostName = cfg.sys.host;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowPing = false;
      allowedTCPPorts = [
        22
        443
      ];
      extraCommands = ''
        iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
        iptables -P INPUT DROP
      '';
    };
  };
  users.users = {
    root = {
      hashedPassword = if (cfg.opt.users.root.passwd != null) then cfg.opt.users.root.passwd else null;
      shell =
        if (cfg.opt.users.root.shell != null) then cfg.opt.users.root.shell else pkgs.bashInteractive;
    };
    ${cfg.opt.users.user.name} = {
      isNormalUser = true;
      name = cfg.opt.users.user.name;
      home = cfg.opt.users.user.home;
      hashedPassword = if (cfg.opt.users.user.passwd != null) then cfg.opt.users.user.passwd else null;
      extraGroups = cfg.opt.users.user.groups;
      shell =
        if (cfg.opt.users.user.shell != null) then cfg.opt.users.user.shell else pkgs.bashInteractive;
    };
  };
  system.stateVersion = if (cfg.opt.system.version != null) then cfg.opt.system.version else "25.05";
  system.autoUpgrade.channel =
    if (cfg.opt.system.channel != null) then cfg.opt.system.channel else null;
  boot.kernelPackages =
    if (cfg.opt.system.kernel != null) then cfg.opt.system.kernel else pkgs.linuxPackages_latest;
  programs = {
    xwayland.enable = true;
    dconf.enable = true;
    git = {
      enable = true;
      package = pkgs.git;
      config = {
        user = {
          name = cfg.opt.git.name;
          email = cfg.opt.git.mail;
        };
      };
    };
  };

  services = {
    displayManager.ly.enable = lib.mkDefault true;
    xserver.enable = true;
    xserver.desktopManager.xterm.enable = false;
    gnome.gnome-keyring.enable = true;
  };

  services.journald.audit = true;
  security.auditd.enable = true;
  # systemd.services.auditd = {
  #   serviceConfig = {
  #     ProtectSystem = "strict";
  #     RestrictAddressFamilies = [ "AF_UNIX" "AF_NETLINK" ];
  #     NoNewPrivileges = true;
  #   };
  # };

  security.loginDefs.settings = {
    SHA_CRYPT_MIN_ROUNDS = 10000;
    SHA_CRYPT_MAX_ROUNDS = 10000;
    PASS_MAX_DAYS = 90;
  };

  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (
          subject.isInGroup("wheel") && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
        {
          return polkit.Result.YES;
        }
      });
    '';
  };

  fileSystems = {
    "/proc" = {
      fsType = "proc";
      options = [
        "defaults"
        "hidepid=2"
      ];
    };
  };
}
