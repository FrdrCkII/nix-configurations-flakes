{
  pkgs,
  cfg,
  user,
  ...
}:
{
  imports = map cfg.lib.relativeToRoot [
    "nix-mod/nixos-home-programs/shell/bash.nix"
    "nix-mod/nixos-home-programs/shell/cli/git.nix"
  ];
  home.packages =
    with pkgs;
    [
      helix
      wget
      curl
      git
    ]
    ++ (lib.optionals (user.packages != null) user.packages);
}
