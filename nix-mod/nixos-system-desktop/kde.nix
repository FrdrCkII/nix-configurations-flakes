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
        home.packages = [ pkgs.kdePackages.karousel ];
        home.file.".local/share/kwin/scripts/karousel" = {
          source = "${pkgs.kdePackages.karousel}/share/kwin/scripts/karousel";
          recursive = true;
        };
      };
    }
    // acc
  ) { } cfg.hom;
}
