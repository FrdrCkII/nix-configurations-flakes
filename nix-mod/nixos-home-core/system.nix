{ pkgs, user, ... }:
{
  home.packages =
    with pkgs;
    [
      helix
      wget
      curl
      git
    ]
    ++ (lib.optionals (user.packages != null) user.packages);
  programs.git = {
    enable = true;
    userName = user.git.name;
    userEmail = user.git.mail;
  };
}
