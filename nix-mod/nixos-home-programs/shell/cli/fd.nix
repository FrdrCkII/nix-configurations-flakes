{ pkgs, ... }:
{
  programs.fd = {
    enable = true;
    package = pkgs.fd;
    hidden = true;
    extraOptions = [
      "--no-ignore"
      "--absolute-path"
    ];
    ignores = [
      ".git/"
    ];
  };
}
