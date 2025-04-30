{ pkgs, cfg, ... }:
{
  programs = {
    bash = {
      completion.enable = true;
      completion.package = pkgs.bash-completion;
      shellAliases = {
        sudo = "doas";
      };
    };
    zsh = {
      enable = true;
      shellAliases = {
        sudo = "doas";
      };
    };
  };
  # https://wiki.nixos.org/wiki/Doas
  # https://wiki.nixos.org/wiki/Sudo
  # https://wiki.archlinuxcn.org/wiki/Doas
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      wheelNeedsPassword = true;
      extraRules = [{
        users = [ cfg.opt.users.user.name ];
        keepEnv = true;
        persist = true;
      }];
    };
  };
}
