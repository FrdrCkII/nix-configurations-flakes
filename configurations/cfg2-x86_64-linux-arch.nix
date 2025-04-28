{ inputs, lib, custom-lib }@custom-args:
rec {
  custom-config = {inherit system packages modules options;};
  homeConfigurations."${system.name}" = custom-lib.linux-home-manager {inherit custom-args custom-config;};
  systemConfigs."${system.name}" = custom-lib.linux-system-manager {inherit custom-args custom-config;};

  system = {
    name = "arch";
    host = "arch";
    config = "cfg2-x86_64-linux-arch";
    system = "x86_64-linux";
    type = "linux";
  };

  packages = rec {
    allowed-unfree-packages = pkg: builtins.elem (inputs.nixpkgs.lib.getName pkg) [
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
        FrdrCkII = inputs.FrdrCkII.packages."${prev.system}";
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
    home-manager-modules = map custom-lib.relativeToRoot [
    ];
    system-manager-modules = map custom-lib.relativeToRoot [
    ];
  };

  options = {
    users = {
      user = {
        name = "FrdrCkII";
        home = "/home/fdk";
        passwd = "$y$j9T$VEQdKCDwBWdnXHWt/G3A80$fIwaranrlJ8PoFlsQkqv2qf2aYSyrC71Wx7dHziBIH6";
        groups = [ "wheel" "networkmanager" ];
      };
      root.passwd = "$y$j9T$0DxglU59Q8weU0vHSodfF0$vp7gYB1HTTEcx/6AAXqCESnKH4Z6EUff/cVmg7zPit.";
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

    system-manager = {
      packages = with packages.pkgs; [
        helix
        fastfetch
        nix-tree
        just
      ];
    };

    home-manager = {
      version = "25.05";
      packages = with packages.pkgs; [
        ffmpeg
      ];
    };
  };

}
