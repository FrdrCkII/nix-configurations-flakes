{
  config,
  lib,
  pkgs,
  cfg,
  ...
}:
{
  xdg.configFile = {
    "zsh/.zimrc".source = cfg.lib.relativeToRoot "dotfiles/${cfg.sys.config}/zimrc";
  };
  home = {
    shell.enableZshIntegration = true;
    shellAliases = {
      zed = "zeditor";
    };
  };
  programs = {
    fd = {
      enable = true;
      package = pkgs.fd;
      hidden = true;
    };
    bat = {
      enable = true;
      package = pkgs.bat;
      config = {
        pager = "less -FR";
        theme = lib.mkDefault "catppuccin-mocha";
      };
    };
    fzf = {
      enable = true;
      package = pkgs.fzf;
      defaultCommand = "fd --type f";
      defaultOptions = [
        "--height 40%"
        "--border"
        "--layout reverse"
        "--preview 'bat --color=always {}'"
        "--bind 'ctrl-/:change-preview-window(50%|hidden|)'"
      ];
      colors = lib.mkDefault {
        "bg+" = "#313244";
        "bg" = "#1e1e2e";
        "spinner" = "#f5e0dc";
        "hl" = "#f38ba8";
        "fg" = "#cdd6f4";
        "header" = "#f38ba8";
        "info" = "#cba6f7";
        "pointer" = "#f5e0dc";
        "marker" = "#f5e0dc";
        "fg+" = "#cdd6f4";
        "prompt" = "#cba6f7";
        "hl+" = "#f38ba8";
      };
    };
    starship = {
      enable = true;
      package = pkgs.starship;
      settings = {
        add_newline = false;
        scan_timeout = 10;
        character = {
          success_symbol = "[>](bold green)";
          error_symbol = "[x](bold red)";
          vimcmd_symbol = "[<](bold green)";
        };
        git_status = {
          ahead = ">";
          behind = "<";
          diverged = "<>";
          renamed = "r";
          deleted = "x";
        };
        aws = {
          symbol = "\\[aws\\]";
        };
        azure = {
          symbol = "\\[az\\]";
        };
        buf = {
          symbol = "\\[buf\\]";
        };
        bun = {
          symbol = "\\[bun\\]";
        };
        c = {
          symbol = "\\[C\\]";
        };
        cpp = {
          symbol = "\\[C++\\]";
        };
        cobol = {
          symbol = "\\[cobol\\]";
        };
        conda = {
          symbol = "\\[conda\\]";
        };
        container = {
          symbol = "\\[container\\]";
        };
        crystal = {
          symbol = "\\[cr\\]";
        };
        cmake = {
          symbol = "\\[cmake\\]";
        };
        daml = {
          symbol = "\\[daml\\]";
        };
        dart = {
          symbol = "\\[dart\\]";
        };
        deno = {
          symbol = "\\[deno\\]";
        };
        dotnet = {
          symbol = "\\[.NET\\]";
        };
        directory = {
          read_only = " ro";
        };
        docker_context = {
          symbol = "\\[docker\\]";
        };
        elixir = {
          symbol = "\\[exs\\]";
        };
        elm = {
          symbol = "\\[elm\\]";
        };
        fennel = {
          symbol = "\\[fnl\\]";
        };
        fossil_branch = {
          symbol = "\\[fossil\\]";
        };
        gcloud = {
          symbol = "\\[gcp\\]";
        };
        git_branch = {
          symbol = "git ";
        };
        gleam = {
          symbol = "\\[gleam\\]";
        };
        golang = {
          symbol = "\\[go\\]";
        };
        gradle = {
          symbol = "\\[gradle\\]";
        };
        guix_shell = {
          symbol = "\\[guix\\]";
        };
        haskell = {
          symbol = "\\[haskell\\]";
        };
        helm = {
          symbol = "\\[helm\\]";
        };
        hg_branch = {
          symbol = "\\[hg\\]";
        };
        java = {
          symbol = "\\[java\\]";
        };
        julia = {
          symbol = "\\[jl\\]";
        };
        kotlin = {
          symbol = "\\[kt\\]";
        };
        lua = {
          symbol = "\\[lua\\]";
        };
        nodejs = {
          symbol = "\\[nodejs\\]";
        };
        memory_usage = {
          symbol = "\\[memory\\]";
        };
        meson = {
          symbol = "\\[meson\\]";
        };
        nats = {
          symbol = "\\[nats\\]";
        };
        nim = {
          symbol = "\\[nim\\]";
        };
        nix_shell = {
          symbol = "\\[nix\\]";
        };
        ocaml = {
          symbol = "\\[ml\\]";
        };
        opa = {
          symbol = "\\[opa\\]";
        };
        os.symbols = {
          AIX = "\\[aix\\]";
          Alpaquita = "\\[alq\\]";
          AlmaLinux = "\\[alma\\]";
          Alpine = "\\[alp\\]";
          Amazon = "\\[amz\\]";
          Android = "\\[andr\\]";
          Arch = "\\[rch\\]";
          Artix = "\\[atx\\]";
          Bluefin = "\\[blfn\\]";
          CachyOS = "\\[cach\\]";
          CentOS = "\\[cent\\]";
          Debian = "\\[deb\\]";
          DragonFly = "\\[dfbsd\\]";
          Emscripten = "\\[emsc\\]";
          EndeavourOS = "\\[ndev\\]";
          Fedora = "\\[fed\\]";
          FreeBSD = "\\[fbsd\\]";
          Garuda = "\\[garu\\]";
          Gentoo = "\\[gent\\]";
          HardenedBSD = "\\[hbsd\\]";
          Illumos = "\\[lum\\]";
          Kali = "\\[kali\\]";
          Linux = "\\[lnx\\]";
          Mabox = "\\[mbox\\]";
          Macos = "\\[mac\\]";
          Manjaro = "\\[mjo\\]";
          Mariner = "\\[mrn\\]";
          MidnightBSD = "\\[mid\\]";
          Mint = "\\[mint\\]";
          NetBSD = "\\[nbsd\\]";
          NixOS = "\\[nix\\]";
          Nobara = "\\[nbra\\]";
          OpenBSD = "\\[obsd\\]";
          OpenCloudOS = "\\[ocos\\]";
          openEuler = "\\[oeul\\]";
          openSUSE = "\\[osuse\\]";
          OracleLinux = "\\[orac\\]";
          Pop = "\\[pop\\]";
          Raspbian = "\\[rasp\\]";
          Redhat = "\\[rhl\\]";
          RedHatEnterprise = "\\[rhel\\]";
          RockyLinux = "\\[rky\\]";
          Redox = "\\[redox\\]";
          Solus = "\\[sol\\]";
          SUSE = "\\[suse\\]";
          Ubuntu = "\\[ubnt\\]";
          Ultramarine = "\\[ultm\\]";
          Unknown = "\\[unk\\]";
          Uos = "\\[uos\\]";
          Void = "\\[void\\]";
          Windows = "\\[win\\]";
        };
        package = {
          symbol = "\\[pkg\\]";
        };
        perl = {
          symbol = "\\[pl\\]";
        };
        php = {
          symbol = "\\[php\\]";
        };
        pijul_channel = {
          symbol = "\\[pijul\\]";
        };
        pixi = {
          symbol = "\\[pixi\\]";
        };
        pulumi = {
          symbol = "\\[pulumi\\]";
        };
        purescript = {
          symbol = "\\[purs\\]";
        };
        python = {
          symbol = "\\[py\\]";
        };
        quarto = {
          symbol = "\\[quarto\\]";
        };
        raku = {
          symbol = "\\[raku\\]";
        };
        rlang = {
          symbol = "\\[r\\]";
        };
        ruby = {
          symbol = "\\[rb\\]";
        };
        rust = {
          symbol = "\\[rs\\]";
        };
        scala = {
          symbol = "\\[scala\\]";
        };
        spack = {
          symbol = "\\[spack\\]";
        };
        solidity = {
          symbol = "\\[solidity\\]";
        };
        status = {
          symbol = "\\[x = {(bold red)\\]";
        };
        sudo = {
          symbol = "\\[sudo\\]";
        };
        swift = {
          symbol = "\\[swift\\]";
        };
        typst = {
          symbol = "\\[typst\\]";
        };
        terraform = {
          symbol = "\\[terraform\\]";
        };
        zig = {
          symbol = "\\[zig\\]";
        };
      };
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      dotDir = ".config/zsh";
      plugins = [
        {
          name = "zsh-zim";
          src = pkgs.zimfw;
        }
      ];
      initContent = lib.mkMerge [
        ''
          ZIM_HOME=~/.config/zsh
          # Install missing modules and update ''${ZIM_HOME}/init.zsh if missing or outdated.
          if [[ ! ''${ZIM_HOME}/init.zsh -nt ''${ZIM_CONFIG_FILE:-''${ZDOTDIR:-''${HOME}}/.zimrc} ]]; then
            source ${config.home.homeDirectory}/.config/zsh/plugins/zsh-zim/zimfw.zsh init
          fi
          # Initialize modules.
          source ''${ZIM_HOME}/init.zsh
        ''
        ''
          export FZF_COMPLETION_TRIGGER='\'
          # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
          # - The first argument to the function ($1) is the base path to start traversal
          # - See the source code (completion.{bash,zsh}) for the details.
          _fzf_compgen_path() {
            fd --follow --exclude ".git" . "$1"
          }
          # Use fd to generate the list for directory completion
          _fzf_compgen_dir() {
            fd --type d --follow --exclude ".git" . "$1"
          }
        ''
        ''
          eval "$(starship init zsh)"
        ''
      ];
    };
  };
}
