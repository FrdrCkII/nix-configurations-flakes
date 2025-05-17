{
  config,
  lib,
  pkgs,
  cfg,
  ...
}:
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

  # https://nixos.wiki/wiki/AMD_GPU
  # https://wiki.archlinuxcn.org/wiki/AMDGPU
  (lib.mkIf cfg.nos.drivers.amd {
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = [ "amdgpu" ];
    # Vulkan
    environment.variables = {
      AMD_VULKAN_ICD = "RADV";
      VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
    };
    hardware.amdgpu.amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };

    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];

    # LACT
    environment.systemPackages = with pkgs; [
      lact
    ];
    systemd = {
      packages = with pkgs; [ lact ];
      services.lactd.wantedBy = [ "multi-user.target" ];
    };

  })

  (lib.mkIf cfg.nos.drivers.nvidia {
    # TODO
  })

]
