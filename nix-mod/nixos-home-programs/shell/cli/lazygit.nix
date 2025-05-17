{ pkgs, cfg, ... }:
{
  imports = map cfg.lib.relativeToRoot [
    "nix-mod/nixos-home-programs/shell/cli/git.nix"
  ];
  programs.lazygit = {
    enable = true;
    package = pkgs.lazygit;
    settings = { };
  };
}
