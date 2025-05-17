{
  lib,
  pkgs,
  cfg,
  ...
}:
{
  programs.sway = {
    enable = true;
    package = pkgs.sway;
    xwayland.enable = true;
  };
  home-manager.users = lib.foldl (
    acc: user:
    {
      ${user.name} = {
        imports = map cfg.lib.relativeToRoot [
          "nix-mod/nixos-home-programs/desktop/sway.nix"
        ];
      };
    }
    // acc
  ) { } cfg.hom;
}
