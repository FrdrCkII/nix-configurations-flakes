{
  lib,
  inputs,
  custom-lib,
}@custom-args:
rec {
  imports = [ "cfg0-none-none-default.nix" ];

  custom-config = {
    inherit
      system
      packages
      system-manager
      home-manager
      ;
  };
  systemConfigs."${system.name}" = custom-lib.linux-system-manager {
    inherit custom-args custom-config;
  };
  homeConfigurations."${system.name}" = lib.foldl (
    acc: user:
    {
      "${user.name}" = custom-lib.linux-home-manager {
        inherit custom-args custom-config user;
      };
    }
    // acc
  ) { } home-manager;

  system = {
    name = "arch";
    host = "arch";
    config = "cfg2-x86_64-linux-arch";
    system = "x86_64-linux";
    type = "linux";
  };

  packages = rec {
    allowed-unfree-packages =
      pkg:
      builtins.elem (inputs.nixpkgs.lib.getName pkg) [
        "wechat-uos"
        "dingtalk"
        "qq"
      ];
    allowed-insecure-packages =
      pkg:
      builtins.elem (inputs.nixpkgs.lib.getName pkg) [
      ];
    overlays = [
      (final: prev: {
        nur = import inputs.nur {
          pkgs = prev;
          nurpkgs = prev;
        };
      })
      (final: prev: {
        FrdrCkII = inputs.FrdrCkII.packages."${prev.system}";
      })
    ];
    pkgs = import inputs.nixpkgs {
      inherit (system) system;
      config.allowUnfreePredicate = allowed-unfree-packages;
      config.permittedInsecurePackages = allowed-insecure-packages;
      overlays = overlays;
    };
  };

  system-manager = {
    packages = with packages.pkgs; [
      ffmpeg
    ];
    modules = map custom-lib.relativeToRoot [
      inputs.nix-system-graphics.systemModules.default
    ];
  };

  home-manager = [
    {
      name = "FrdrCkII";
      home = "/home/fdk";
      passwd = "$y$j9T$VEQdKCDwBWdnXHWt/G3A80$fIwaranrlJ8PoFlsQkqv2qf2aYSyrC71Wx7dHziBIH6";
      groups = [
        "wheel"
        "networkmanager"
        "gamemode"
      ];
      version = "25.05";
      shell = packages.pkgs.zsh;
      git = {
        name = "FrdrCkII";
        mail = "c2h5oc2h4@outlook.com";
      };
      packages = with packages.pkgs; [
        ffmpeg
      ];
      modules = map custom-lib.relativeToRoot [
      ];
    }
  ];

}
