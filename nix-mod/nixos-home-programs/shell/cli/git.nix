{ pkgs, user, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.git;
    userName = user.git.name;
    userEmail = user.git.mail;
    aliases = {
      it = "init";
      co = "checkout";
    };
  };
}
