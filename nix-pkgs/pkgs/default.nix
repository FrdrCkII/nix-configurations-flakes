{
  pkgs ? import <nixpkgs> { },
}:
{
  lib = import ../lib { inherit pkgs; };
  modules = import ../modules;
  overlays = import ../overlays;

  aria2-fast = pkgs.callPackage ./aria2-fast { };
}
