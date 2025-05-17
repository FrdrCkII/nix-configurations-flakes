{
  config,
  lib,
  pkgs,
  cfg,
  ...
}:
{
  imports = map cfg.lib.relativeToRoot [
    "nix-mod/nixos-home-programs/shell/cli/git.nix"
    "nix-mod/nixos-home-programs/shell/cli/bat.nix"
    "nix-mod/nixos-home-programs/shell/cli/fd.nix"
    "nix-mod/nixos-home-programs/shell/cli/fzf.nix"
    "nix-mod/nixos-home-programs/shell/cli/starship.nix"
  ];
  xdg.configFile = {
    "zsh/.zimrc".source = cfg.lib.relativeToRoot "dotfiles/${cfg.sys.config}/zimrc";
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    dotDir = ".config/zsh";
    plugins = [
      {
        name = "zsh-zim";
        src = pkgs.zimfw;
      }
    ];
    initContent = lib.mkMerge [
      ''
        ZIM_HOME=~/.config/zsh
        # Install missing modules and update ''${ZIM_HOME}/init.zsh if missing or outdated.
        if [[ ! ''${ZIM_HOME}/init.zsh -nt ''${ZIM_CONFIG_FILE:-''${ZDOTDIR:-''${HOME}}/.zimrc} ]]; then
          source ${config.home.homeDirectory}/.config/zsh/plugins/zsh-zim/zimfw.zsh init
        fi
        # Initialize modules.
        source ''${ZIM_HOME}/init.zsh
      ''
      ''
        export FZF_COMPLETION_TRIGGER='\'
        # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
        # - The first argument to the function ($1) is the base path to start traversal
        # - See the source code (completion.{bash,zsh}) for the details.
        _fzf_compgen_path() {
          fd --follow --exclude ".git" . "$1"
        }
        # Use fd to generate the list for directory completion
        _fzf_compgen_dir() {
          fd --type d --follow --exclude ".git" . "$1"
        }
      ''
      ''
        eval "$(starship init zsh)"
      ''
    ];
  };
}
