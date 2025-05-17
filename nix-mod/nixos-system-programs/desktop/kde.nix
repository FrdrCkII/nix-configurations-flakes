{
  lib,
  pkgs,
  cfg,
  ...
}:
{
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    oxygen
  ];
  i18n.inputMethod.fcitx5.plasma6Support = true;
  home-manager.users = lib.foldl (
    acc: user:
    {
      ${user.name} = {
        imports = map cfg.lib.relativeToRoot [
          "nix-mod/nixos-home-programs/desktop/kde.nix"
        ];
      };
    }
    // acc
  ) { } cfg.hom;
}
