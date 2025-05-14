{ ... }:
{
  services.journald.audit = true;
  security.auditd.enable = true;

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
