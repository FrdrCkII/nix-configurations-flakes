{
  lib,
  pkgs,
  cfg,
  ...
}:
{
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri;
  environment.systemPackages = with pkgs; [ xwayland-satellite ];
  home-manager.users = lib.foldl (
    acc: user:
    {
      ${user.name} = {
        imports = map cfg.lib.relativeToRoot [
          "nix-mod/nixos-home-programs/desktop/niri.nix"
        ];
      };
    }
    // acc
  ) { } cfg.hom;
}
