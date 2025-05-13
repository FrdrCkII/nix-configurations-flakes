{ pkgs, ... }:
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      xorg.libX11
      xorg.libX11.dev
      xorg.libICE
      xorg.libSM
      xorg.libXinerama
      fontconfig
      libGL
      libxkbcommon
      zlib
      icu
    ];
  };
}
