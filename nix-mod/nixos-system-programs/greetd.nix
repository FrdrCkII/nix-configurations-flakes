{
  config,
  lib,
  pkgs,
  ...
}:
let
  sessionsDir = "${config.services.displayManager.sessionData.desktops}/share";
in
{
  services.displayManager.ly.enable = lib.mkForce false;
  services.xserver.displayManager.startx.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${lib.getExe pkgs.greetd.tuigreet} \
            --time \
            --width 180 \
            --greeting "Welcom to NixOS" \
            --asterisks \
            --user-menu \
            --remember \
            --remember-session \
            --sessions ${sessionsDir}/wayland-sessions
            # --xsessions ${sessionsDir}/xsessions
        '';
        user = "greeter";
      };
    };
  };
  systemd.services.greetd = {
    serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # anti-spam
      TTYReset = true; # anti-spam
      TTYVHangup = true; # anti-spam
      TTYVTDisallocate = true; # anti-spam
    };
  };
}
