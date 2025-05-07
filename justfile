cl:
    @doas nix profile wipe-history --profile /nix/var/nix/profiles/system
    @doas nix-collect-garbage --delete-old
    @nix-collect-garbage --delete-old

up:
    @nix flake update
    @git add flake.lock

nbd host="nixos":
    @git add *
    @doas chown root /home/fdk/.cache/nix/tarball-cache
    @doas nixos-rebuild switch --flake .#{{host}} --impure
    @doas chown FrdrCkII /home/fdk/.cache/nix/tarball-cache
