{ pkgs, ... }:
{
  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetch;
    settings = {
      "logo" = {
        "padding" = {
          "top" = 1;
        };
      };
      "display" = {
        "separator" = " => ";
      };
      "modules" = [
        "break"
        {
          "type" = "os";
          "key" = " DISTRO";
          "keyColor" = "yellow";
        }
        {
          "type" = "kernel";
          "key" = "├ kernel";
          "keyColor" = "yellow";
        }
        {
          "type" = "packages";
          "key" = "├󰏖 packages";
          "keyColor" = "yellow";
        }
        {
          "type" = "shell";
          "key" = "└ shell";
          "keyColor" = "yellow";
        }
        {
          "type" = "wm";
          "key" = " DE/WM";
          "keyColor" = "blue";
        }
        {
          "type" = "wmtheme";
          "key" = "├󰉼 wmtheme";
          "keyColor" = "blue";
        }
        {
          "type" = "icons";
          "key" = "├󰀻 icons";
          "keyColor" = "blue";
        }
        {
          "type" = "cursor";
          "key" = "├ cursor";
          "keyColor" = "blue";
        }
        {
          "type" = "terminalfont";
          "key" = "├ terminalfont";
          "keyColor" = "blue";
        }
        {
          "type" = "terminal";
          "key" = "└ terminal";
          "keyColor" = "blue";
        }
        {
          "type" = "host";
          "key" = "󰌢 SYSTEM";
          "keyColor" = "green";
        }
        {
          "type" = "cpu";
          "key" = "├󰻠 CPU";
          "keyColor" = "green";
        }
        {
          "type" = "gpu";
          "key" = "├󰻑 GPU";
          "format" = "{2}";
          "keyColor" = "green";
        }
        {
          "type" = "display";
          "key" = "├󰍹 display";
          "keyColor" = "green";
          "compactType" = "original-with-refresh-rate";
        }
        {
          "type" = "memory";
          "key" = "├󰾆 memory";
          "keyColor" = "green";
        }
        {
          "type" = "swap";
          "key" = "├󰓡 swap";
          "keyColor" = "green";
        }
        {
          "type" = "uptime";
          "key" = "├󰅐 uptime";
          "keyColor" = "green";
        }
        {
          "type" = "display";
          "key" = "└󰍹 display";
          "keyColor" = "green";
        }
        {
          "type" = "sound";
          "key" = " AUDIO";
          "format" = "{2}";
          "keyColor" = "magenta";
        }
        {
          "type" = "player";
          "key" = "├󰥠 player";
          "keyColor" = "magenta";
        }
        {
          "type" = "media";
          "key" = "└󰝚 media";
          "keyColor" = "magenta";
        }
        "break"
      ];
    };
  };
}
