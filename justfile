cl:
    @sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
    @sudo nix-collect-garbage --delete-old
    @nix-collect-garbage --delete-old

up:
    @nix flake update
    @git add flake.lock

nbd host="nixos":
    @git add *
    @sudo nixos-rebuild switch --flake .#{{host}} --impure

ntt host="nixos":
    @git add *
    @sudo nixos-rebuild test --flake .#{{host}} --impure
