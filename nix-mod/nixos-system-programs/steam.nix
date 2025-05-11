{ config, lib, pkgs, ... }:
{
  # https://wiki.archlinuxcn.org/wiki/Steam
  # https://wiki.nixos.org/wiki/Steam
  hardware.steam-hardware.enable = true;
  # https://wiki.archlinuxcn.org/wiki/MangoHud
  environment.systemPackages = with pkgs; [
    gamescope
    gamemode
    mangohud
    mangojuice
  ];
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
      settings = {
        general = {
          softrealtime = "auto";
          renice = 15;
        };
      };
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
          SDL_VIDEODRIVER = "wayland,x11";
        };
        extraPkgs = pkgs: with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          xorg.libxcb
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils

          # fix CJK fonts
          source-sans
          source-serif
          source-han-sans
          source-han-serif

          # audio
          pipewire

          # other common
          udev
          alsa-lib
          vulkan-loader
          xorg.libX11
          xorg.libXcursor
          xorg.libXi
          xorg.libXrandr # To use the x11 feature
          libxkbcommon
          wayland # To use the wayland feature
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
