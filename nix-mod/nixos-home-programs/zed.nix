{ lib, pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor;
    extraPackages = with pkgs; [
      nixd
      nil
      nixfmt-rfc-style
    ];
    userSettings = {
      icon_theme = lib.mkDefault "Zed (Default)";
      ui_font_size = lib.mkDefault 16;
      buffer_font_size = lib.mkDefault 16;
      buffer_font_family = lib.mkForce "";
      ui_font_family = lib.mkForce "";
      theme = lib.mkDefault {
        mode = "system";
        light = "Ayu Dark";
        dark = "One Dark";
      };
      lsp = {
        rust-analyzer = {
          binary = {
            ignore_system_version = false;
          };
        };
        nil = {
          settings = {
            diagnostics = {
              ignored = [ "unused_binding" ];
            };
          };
          nix = {
            flake = {
              autoArchive = true;
              autoEvalInputs = true;
            };
          };
        };
      };
      languages = {
        Nix = {
          language_servers = [
            "!nixd"
            "nil"
          ];
          formatter = {
            external = {
              command = "nixfmt";
            };
          };
        };
      };
    };
  };
}
