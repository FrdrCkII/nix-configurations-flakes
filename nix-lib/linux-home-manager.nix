{ custom-args, custom-config }:
let
  inherit (custom-args.inputs) home-manager;
  extraSpecialArgs = {
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
home-manager.lib.homeManagerConfiguration {
  inherit extraSpecialArgs;
  modules = extraSpecialArgs.cfg.mod.home-manager-modules;
}
