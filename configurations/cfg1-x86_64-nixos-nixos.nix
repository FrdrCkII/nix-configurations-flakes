{ inputs, lib, custom-lib }@custom-args:
rec {
  custom-config = {inherit system packages modules options;};
  nixosConfigurations."${system.name}" = custom-lib.nixos-system {inherit custom-args custom-config;};

  system = {
    name = "nixos";
    host = "nixos";
    config = "cfg1-x86_64-nixos-nixos";
    system = "x86_64-linux";
    type = "nixos";
  };

  packages = rec {
    allowed-unfree-packages = pkg: builtins.elem (inputs.nixpkgs.lib.getName pkg) [
      "vscode"
      "steam"
      "steam-unwrapped"
      "wechat-uos"
      "dingtalk"
      "qq"
    ];
    allowed-insecure-packages = pkg: builtins.elem (inputs.nixpkgs.lib.getName pkg) [
    ];
    overlays = [
      (final: prev: {
        nur = import inputs.nur {
          pkgs = prev;
          nurpkgs = prev;
          # repoOverrides = { paul = import paul { pkgs = prev; }; };
        };
      })
      ( final: prev: {
        nix-alien = inputs.nix-alien.packages."${prev.system}";
      } )
      ( final: prev: {
        FrdrCkII = inputs.FrdrCkII.packages."${prev.system}";
      } )
      ( final: prev: {
        local = inputs.local.packages."${prev.system}";
      } )
    ];
    pkgs = import inputs.nixpkgs {
      inherit (system) system;
      config.allowUnfreePredicate = allowed-unfree-packages;
      config.permittedInsecurePackages = allowed-insecure-packages;
      overlays = overlays;
    };
  };

  modules = {
    nixos-modules = map custom-lib.relativeToRoot [
      "nix-mod/${system.config}/configuration.nix"
      "nix-mod/${system.config}/hardware-configuration.nix"

      "nix-mod/nixos-system-core/boot.nix"
      "nix-mod/nixos-system-core/drivers.nix"
      "nix-mod/nixos-system-core/greetd.nix"
      "nix-mod/nixos-system-core/kmscon.nix"
      "nix-mod/nixos-system-core/locale.nix"
      "nix-mod/nixos-system-core/nix-ld.nix"
      "nix-mod/nixos-system-core/nixpkgs.nix"
      "nix-mod/nixos-system-core/system.nix"

      "nix-mod/nixos-system-programs/shell.nix"
      "nix-mod/nixos-system-programs/steam.nix"

      "nix-mod/nixos-system-desktop/lxqt.nix"
      "nix-mod/nixos-system-desktop/niri.nix"
    ];
    home-manager-modules = map custom-lib.relativeToRoot [
      "nix-mod/nixos-home-core/gtkqt.nix"
      "nix-mod/nixos-home-core/locale.nix"
      "nix-mod/nixos-home-core/system.nix"
      "nix-mod/nixos-home-core/xdg.nix"

      "nix-mod/nixos-home-programs/shell.nix"
      "nix-mod/nixos-home-programs/ghostty.nix"
      "nix-mod/nixos-home-programs/gnome-keyring.nix"
      "nix-mod/nixos-home-programs/aria2.nix"
      "nix-mod/nixos-home-programs/fastfetch.nix"
      "nix-mod/nixos-home-programs/helix.nix"
      "nix-mod/nixos-home-programs/rustup.nix"
      "nix-mod/nixos-home-programs/yazi.nix"
      "nix-mod/nixos-home-programs/zed.nix"

      "nix-mod/nixos-home-desktop/lxqt.nix"
      "nix-mod/nixos-home-desktop/niri.nix"
    ];
  };

  options = {
    users = {
      user = {
        name = "FrdrCkII";
        home = "/home/fdk";
        passwd = "$y$j9T$VEQdKCDwBWdnXHWt/G3A80$fIwaranrlJ8PoFlsQkqv2qf2aYSyrC71Wx7dHziBIH6";
        groups = [ "wheel" "networkmanager" "gamemode" ];
        shell = packages.pkgs.zsh;
      };
      root = {
        passwd = "$y$j9T$0DxglU59Q8weU0vHSodfF0$vp7gYB1HTTEcx/6AAXqCESnKH4Z6EUff/cVmg7zPit.";
        shell = packages.pkgs.zsh;
      };
    };
    git = {
      name = "FrdrCkII";
      mail = "c2h5oc2h4@outlook.com";
    };
    drivers = {
      amd = true;
      nvidia = false;
      intel = false;
    };
    boot = {
      loader = "grub";
      efi-mount-point = "/boot/efi";
    };

    system = {
      version = "25.05";
      channel = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-unstable";
      kernel = packages.pkgs.linuxPackages_latest;
      packages = with packages.pkgs; [
        toybox
        fastfetch
        nix-tree
        nssTools
        just
        # local.steamcommunity-302
        nix-alien.nix-alien
      ];
    };

    home-manager = {
      version = "25.05";
      packages = with packages.pkgs; [
        wechat-uos qq
        libreoffice
        ffmpeg gimp
        vscode
      ];
    };
  };

}
