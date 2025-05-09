{ config, lib, pkgs, cfg, ... }:
lib.mkMerge [
  {
    # 驱动
    # https://wiki.nixos.org/wiki/Graphics
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    # PipWire
    # https://wiki.nixos.org/wiki/PipeWire
    # https://wiki.archlinuxcn.org/wiki/PipeWire
    environment.systemPackages = with pkgs; [ pulseaudio ];
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      package = pkgs.pipewire;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber = {
        enable = true;
      };
    };
  }

  # https://wiki.nixos.org/wiki/AMD_GPU
  # https://wiki.archlinuxcn.org/wiki/AMDGPU
  ( lib.mkIf (cfg.opt.drivers.amd) {
    # Vulkan
    environment.variables.AMD_VULKAN_ICD = "RADV";
    hardware.graphics = {
      extraPackages = with pkgs; [
        mesa
        amdvlk
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.mesa
        driversi686Linux.amdvlk
      ];
    };
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = [ "amdgpu" ];

    # LACT
    environment.systemPackages = with pkgs; [
      lact
    ];
    systemd = {
      packages = with pkgs; [ lact ];
      services.lactd.wantedBy = ["multi-user.target"];
    };

  } )

  ( lib.mkIf (cfg.opt.drivers.nvidia) {
    # TODO: need update
    boot.extraModprobeConfig = ''
      blacklist nouveau
      options nouveau modeset=0
    '';
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  } )

]
