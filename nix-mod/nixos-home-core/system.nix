{ pkgs, cfg, ... }:
{
  programs.home-manager.enable = true;
  home = {
    username = cfg.opt.users.user.name;
    homeDirectory = cfg.opt.users.user.home;
    stateVersion = cfg.opt.home-manager.version;
    packages =
      with pkgs;
      [
        helix
        wget
        curl
      ]
      ++ cfg.opt.home-manager.packages;
  };
  programs.git = {
    enable = true;
    userName = cfg.opt.git.name;
    userEmail = cfg.opt.git.mail;
  };
}
