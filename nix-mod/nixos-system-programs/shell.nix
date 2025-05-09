{ pkgs, cfg, ... }:
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
  # https://wiki.nixos.org/wiki/Doas
  # https://wiki.nixos.org/wiki/Sudo
  # https://wiki.archlinuxcn.org/wiki/Doas
  security = {
    sudo.enable = false;
    sudo-rs = {
      enable = true;
    };
    doas = {
      enable = false;
      wheelNeedsPassword = true;
      extraRules = [{
        users = [ cfg.opt.users.user.name ];
        keepEnv = true;
        persist = true;
      }];
    };
  };
}
