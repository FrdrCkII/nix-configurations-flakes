{ lib, pkgs, cfg, ... }:
{
  programs = {
    bash = {
      completion.enable = true;
      completion.package = pkgs.bash-completion;
    };
    zsh = {
      enable = true;
    };
  };
}
