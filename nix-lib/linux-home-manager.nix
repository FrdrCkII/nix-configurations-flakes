{
  custom-args,
  custom-config,
  user,
}:
let
  inherit (custom-args.inputs) home-manager;
  extraSpecialArgs = {
    inherit (custom-args) inputs;
    cfg = {
      sys = custom-config.system;
      pkg = custom-config.packages;
      sym = custom-config.system-manager;
      hom = user;
      lib = custom-args.custom-lib;
    };
  };
in
home-manager.lib.homeManagerConfiguration {
  inherit extraSpecialArgs;
  modules = extraSpecialArgs.cfg.hom.modules;
}
