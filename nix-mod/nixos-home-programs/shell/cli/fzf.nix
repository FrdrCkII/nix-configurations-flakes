{
  lib,
  pkgs,
  cfg,
  ...
}:
{
  imports = map cfg.lib.relativeToRoot [
    "nix-mod/nixos-home-programs/shell/cli/fd.nix"
    "nix-mod/nixos-home-programs/shell/cli/bat.nix"
  ];
  programs.fzf = {
    enable = true;
    package = pkgs.fzf;
    defaultCommand = "fd --type f";
    defaultOptions = [
      "--height 40%"
      "--border"
      "--layout reverse"
      "--preview 'bat --color=always {}'"
      "--bind 'ctrl-/:change-preview-window(50%|hidden|)'"
    ];
    colors = lib.mkDefault {
      "bg+" = "#313244";
      "bg" = "#1e1e2e";
      "spinner" = "#f5e0dc";
      "hl" = "#f38ba8";
      "fg" = "#cdd6f4";
      "header" = "#f38ba8";
      "info" = "#cba6f7";
      "pointer" = "#f5e0dc";
      "marker" = "#f5e0dc";
      "fg+" = "#cdd6f4";
      "prompt" = "#cba6f7";
      "hl+" = "#f38ba8";
    };
  };
}
