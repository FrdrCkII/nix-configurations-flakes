{ pkgs, ... }:
{
  services = {
    journald.audit = true;

    clamav = {
      package = pkgs.clamav;
      scanner = {
        enable = true;
        interval = "*-*-* 04:00:00";
        scanDirectories = [
          "/home"
          "/data"
          "/var/lib"
          "/var/tmp"
          "/tmp"
          "/etc"
        ];
      };
      updater = {
        enable = true;
        interval = "hourly";
        frequency = 12;
        settings = { };
      };
      fangfrisch = {
        enable = true;
        interval = "hourly";
        settings = { };
      };
      daemon = {
        enable = true;
        settings = { };
      };
    };
  };

  security = {
    auditd.enable = true;
    audit = {
      enable = true;
      failureMode = "printk";
      backlogLimit = 64;
      rateLimit = 0;
      rules = [

      ];
    };

    loginDefs.settings = {
      SHA_CRYPT_MIN_ROUNDS = 10000;
      SHA_CRYPT_MAX_ROUNDS = 10000;
      PASS_MAX_DAYS = 90;
    };

    polkit = {
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
