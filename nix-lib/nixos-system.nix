{ custom-args, custom-config }:
let
  inherit (custom-args) inputs lib;
  inherit (custom-args.inputs) nixpkgs home-manager;
  system = custom-config.system.system;
  specialArgs = {
    inherit (custom-args) inputs;
    cfg = {
      sys = custom-config.system;
      pkg = custom-config.packages;
      nos = custom-config.nixos;
      hom = custom-config.home-manager;
      lib = custom-args.custom-lib;
    };
  };
in
nixpkgs.lib.nixosSystem {
  inherit system specialArgs;
  modules =
    specialArgs.cfg.nos.modules
    ++ (lib.optionals (custom-config.home-manager != null && custom-config.home-manager != [ ]) [
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "home-manager.backup";
          extraSpecialArgs = specialArgs;
          users = lib.foldl (
            acc: user:
            {
              "${user.name}" = {
                _module.args = { inherit user; };
                programs.home-manager.enable = true;
                imports = user.modules;
                home = {
                  username = user.name;
                  homeDirectory = user.home;
                  stateVersion = user.version;
                };
              };
            }
            // acc
          ) { } custom-config.home-manager;
        };
      }
    ]);
}
