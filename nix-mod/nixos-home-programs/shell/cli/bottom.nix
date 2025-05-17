{ pkgs, ... }:
{
  programs.bottom = {
    enable = true;
    package = pkgs.bottom;
    settings = {
      flags = {
        avg_cpu = true;
        temperature_type = "c";
      };
    };
  };
}
