{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome-keyring
    libgnome-keyring
    seahorse
  ];
  systemd.user.services.gnome-keyring-daemon = {
    Unit = {
      Description = "GNOME Keyring";
    };
    Service = {
      ExecStart = "${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --start --foreground";
      Restart = "on-abort";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
