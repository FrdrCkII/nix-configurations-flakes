{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.karousel
  ];
  home.file.".local/share/kwin/scripts/karousel" = {
    source = "${pkgs.kdePackages.karousel}/share/kwin/scripts/karousel";
    recursive = true;
  };
}
