{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [ pwvucontrol ];
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = lib.mkDefault {
      niriBar = {
        layer = "top";
        position = "top";
        height = 0;
        modules-left = [ ];
        modules-center = [ "niri/window" ];
        modules-right = [
          "tray"
          "pulseaudio"
          "network"
          "clock"
        ];
        "niri/workspaces" = {
          "disable-scroll" = true;
          "all-outputs" = false;
          "format" = "<span color='#9f9fcf'>[{value}]</span>";
        };
        "tray" = {
          "icon-size" = 16;
          "spacing" = 4;
        };
        "pulseaudio" = {
          "format" = "<span color='#9f9fcf'>[{icon} |{volume}%]</span>";
          "format-bluetooth" = "<span color='#9f9fcf'>[{icon} |{volume}%]</span>";
          "format-muted" = "<span color='#9f9fcf'>[|静音]</span>";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "phone-muted" = "";
            "portable" = "";
            "car" = "";
            "default" = [
              ""
              ""
            ];
          };
          "scroll-step" = 5;
          "on-click" = "pwvucontrol";
          "on-click-right" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "ignored-sinks" = [ "Easy Effects Sink" ];
        };
        "network" = {
          "format-wifi" = "<span color='#9f9fcf'>[ |{essid}|{signalStrength}%]</span>";
          "format-ethernet" = "<span color='#9f9fcf'>[ |{ifname}|{ipaddr}/{cidr}]</span>";
          "format-linked" = "<span color='#9f9fcf'>[ |{ifname}|无IP]</span>";
          "format-disconnected" = "<span color='#9f9fcf'>[断开]</span>";
          "format-alt" = "<span color='#9f9fcf'>[{ifname}|{ipaddr}/{cidr}]</span>";
        };
        "clock" = {
          "format" = "<span color='#9f9fcf'>[{:L%Y-%b-%d|%A|%R}]</span>";
          "tooltip-format" = "\n<span size='9pt' font='WenQuanYi Zen Hei Mono'>{calendar}</span>";
          "calendar" = {
            "mode" = "mounth";
            "mode-mon-col" = 2;
            "weeks-pos" = "right";
            "on-scroll" = 1;
            "format" = {
              "months" = "<span color='#ffead3'><b>{}</b></span>";
              "days" = "<span color='#ecc6d9'><b>{}</b></span>";
              "weeks" = "<span color='#99ffdd'><b>W{}</b></span>";
              "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
              "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          "actions" = {
            "on-click-forward" = "tz_up";
            "on-click-backward" = "tz_down";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };
      };
    };
    style = lib.mkDefault ''
      * {
          border: none;
          border-radius: 0;
          min-height: 0;
          font-family: "JetBrainsMono Nerd Font";
          font-weight: 500;
          font-size: 13px;
          padding: 0;
      }
      window#waybar {
          background: #1d2021;
          border: 2px solid #3c3836;
      }
      tooltip {
          background-color: #1d2021;
          border: 2px solid #7c6f64;
      }
      #workspaces {
          background-color: #303536;
          border: 2px solid #434a4c;
          margin: 2px 0px 2px 2px;
      }
      #workspaces button {
          all: initial;
          min-width: 0;
          box-shadow: inset 0 -3px transparent;
          padding: 2px 4px;
          color: #c7ab7a;
      }
      #workspaces button.focused {
          color: #ddc7a1;
      }
      #workspaces button.urgent {
          background-color: #e78a4e;
      }
      #tray,
      #clock,
      #network,
      #pulseaudio {
          margin: 2px 2px 2px 0px;
          padding: 2px 2px;
      }
      #tray,
      #clock,
      #network,
      #pulseaudio {
          background-color: #303536;
          border: 2px solid #434a4c;
          color: #1d2021;
      }
    '';
  };
}
