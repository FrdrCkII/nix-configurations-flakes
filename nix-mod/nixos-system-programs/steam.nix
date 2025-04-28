{ config, lib, pkgs, ... }:
{
  # https://wiki.archlinuxcn.org/wiki/Steam
  # https://wiki.nixos.org/wiki/Steam
  hardware.steam-hardware.enable = true;
  programs = {
    # https://wiki.archlinuxcn.org/wiki/Gamescope
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    # https://wiki.archlinuxcn.org/wiki/GameMode
    # https://wiki.nixos.org/wiki/GameMode
    gamemode = {
      enable = true;
      enableRenice = true;
    };
    java = {
      enable = true;
      package = pkgs.jdk;
    };
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraEnv = {
          MANGOHUD = true;
        };
        extraPkgs = pkgs: with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ];
      };
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extest.enable = true;
      fontPackages = builtins.filter lib.types.package.check config.fonts.packages
      ++ (with pkgs; [
        wqy_zenhei
      ]);
      extraPackages = with pkgs; [
        gamescope
        gamemode
        # https://wiki.archlinuxcn.org/wiki/MangoHud
        mangohud
        mangojuice
      ];
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
      gamescopeSession.enable = true;
      gamescopeSession.args = [
        "--xwayland-count 2"
        "-e"
        "--mangoapp"
      ];
    };
  };
}
