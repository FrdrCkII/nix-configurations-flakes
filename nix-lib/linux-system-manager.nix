{ custom-args, custom-config }:
let
  inherit (custom-args.inputs) system-manager;
  extraSpecialArgs = {
    inherit (custom-args) inputs;
    cfg = {
      sys = custom-config.system;
      pkg = custom-config.packages;
      sym = custom-config.system-manager;
      hom = custom-config.home-manager;
      lib = custom-args.custom-lib;
    };
  };
in
system-manager.lib.makeSystemConfig {
  inherit extraSpecialArgs;
  modules = extraSpecialArgs.cfg.sym.modules;
}
