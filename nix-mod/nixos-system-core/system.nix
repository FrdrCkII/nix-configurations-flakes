{
  lib,
  pkgs,
  cfg,
  ...
}:
{
  imports = map cfg.lib.relativeToRoot [
    "nix-mod/nixos-system-core/system/boot.nix"
    "nix-mod/nixos-system-core/system/drivers.nix"
    "nix-mod/nixos-system-core/system/locale.nix"
    "nix-mod/nixos-system-core/system/nixpkgs.nix"
    "nix-mod/nixos-system-core/system/users.nix"
    "nix-mod/nixos-system-programs/shell.nix"
  ];
  environment.systemPackages =
    with pkgs;
    [
      helix
      wget
      curl
      git
      gcc
      clang
      llvmPackages_latest.bintools
      rustc
    ]
    ++ (lib.optionals (cfg.nos.packages != null) cfg.nos.packages);
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
  users.users.root = {
    hashedPassword = lib.mkIf (cfg.nos.passwd != null) cfg.nos.passwd;
    shell = lib.mkIf (cfg.nos.shell != null) cfg.nos.shell;
  };
  system.stateVersion = lib.mkIf (cfg.nos.version != null) cfg.nos.version;
  system.autoUpgrade.channel = lib.mkIf (cfg.nos.channel != null) cfg.nos.channel;
  boot.kernelPackages = lib.mkIf (cfg.nos.kernel != null) cfg.nos.kernel;
  programs = {
    xwayland.enable = true;
    dconf.enable = true;
  };
  services = {
    displayManager.ly.enable = lib.mkDefault true;
    xserver.enable = true;
    xserver.desktopManager.xterm.enable = false;
    gnome.gnome-keyring.enable = true;
  };
}
