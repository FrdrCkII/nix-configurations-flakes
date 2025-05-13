{
  config,
  lib,
  pkgs,
  ...
}:
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
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };
  programs = {
    # https://wiki.archlinuxcn.org/wiki/Gamescope
    gamescope = {
      enable = true;
      # 启用这个选项会允许gamescope调整自身优先级，但同时也会导致无法通过steam启动嵌套会话
      # https://discourse.nixos.org/t/unable-to-activate-gamescope-capsysnice-option/37843
      # 更详细的内容请看这个pr https://github.com/NixOS/nixpkgs/pull/351928
      # 因此建议关闭并使用ananicy调整优先级
      # https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=ananicy
      capSysNice = false;
      # 建议参数
      # -W 1920 -H 1080 -r 60 -w 1920 -h 1080 -f --force-grab-cursor --backend sdl --
      # fsr
      # -W 1920 -H 1080 -r 60 -w 1280 -h 720 -F fsr -f --force-grab-cursor --backend sdl --
    };
    # https://wiki.archlinuxcn.org/wiki/GameMode
    # https://wiki.nixos.org/wiki/GameMode
    gamemode = {
      enable = true;
      # 优先级已经由ananicy进行调整了
      enableRenice = false;
      settings = {
        general = {
          softrealtime = "auto";
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
        extraPkgs =
          pkgs: with pkgs; [
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
      fontPackages =
        builtins.filter lib.types.package.check config.fonts.packages
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
