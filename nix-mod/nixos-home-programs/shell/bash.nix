{ pkgs, cfg, ... }:
{
  imports = map cfg.lib.relativeToRoot [
    "nix-mod/nixos-home-programs/shell/cli/git.nix"
  ];
  home = {
    shell.enableZshIntegration = true;
    shellAliases = {
      zed = "zeditor";
    };
  };
}
