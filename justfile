cl:
    @doas nix profile wipe-history --profile /nix/var/nix/profiles/system
    @doas nix-collect-garbage --delete-old
    @nix-collect-garbage --delete-old

nbd host="nixos":
    @git add *
    @doas nixos-rebuild switch --flake .#{{host}} --impure
