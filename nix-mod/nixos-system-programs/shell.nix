{ pkgs, ... }:
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
  security = {
    sudo.enable = false;
    sudo-rs.enable = true;
  };
}
