{ inputs, pkgs, ... }:
{
  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];
  environment.systemPackages = with pkgs; [
    (rust-bin.selectLatestNightlyWith (
      toolchain:
      (toolchain.default.override {
        extensions = [
          "rust-src"
          "rust-analyzer"
        ];
        targets = [
          "x86_64-unknown-linux-gnu"
          "x86_64-unknown-none"
          "riscv64gc-unknown-none-elf"
          "riscv64imac-unknown-none-elf"
        ];
      })
    ))
    rustup
  ];
}
