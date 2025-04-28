{ custom-args, custom-config }: let
  inherit (custom-args.inputs) system-manager nix-system-graphics;
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
in system-manager.lib.makeSystemConfig {
  inherit extraSpecialArgs;
  modules = [nix-system-graphics.systemModules.default]
    ++ extraSpecialArgs.cfg.mod.system-manager-modules;
}
