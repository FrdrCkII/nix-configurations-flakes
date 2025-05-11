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
      mod = custom-config.modules;
      opt = custom-config.options;
      lib = custom-args.custom-lib;
    };
  };
in
nixpkgs.lib.nixosSystem {
  inherit system specialArgs;
  modules =
    specialArgs.cfg.mod.nixos-modules
    ++ (lib.optionals ((lib.lists.length specialArgs.cfg.mod.home-manager-modules) > 0) [
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "home-manager.backup";
        home-manager.extraSpecialArgs = specialArgs;
        home-manager.users."${specialArgs.cfg.opt.users.user.name}".imports =
          specialArgs.cfg.mod.home-manager-modules;
      }
    ])
    ++ [
      inputs.nix-index-database.nixosModules.nix-index
      inputs.stylix.nixosModules.stylix
    ];
}
