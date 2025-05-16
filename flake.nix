/*
  官方手册 https://nixos.org/manual/nixos/unstable/
  官方wiki https://wiki.nixos.org/wiki/NixOS_Wiki/zh-cn
  官方中文网站 https://nixos-cn.org/
  选项&软件包查询 https://search.nixos.org/options?
  NUR软件包查询 https://nur.nix-community.org/
  home-manager选项查询 https://home-manager-options.extranix.com/?query=&release=master
  中文社区github https://github.com/nixos-cn
  社区大佬的配置文件 https://github.com/NixOS-CN/NixOS-CN-telegram
  中文教程 https://nixos-and-flakes.thiscute.world/zh/
  上文作者的配置文件 https://github.com/ryan4yin/nix-config
  视频教程 https://www.bilibili.com/video/BV1yxzkYYE3E/
  视频作者的配置文件 https://github.com/novel2430/MyNix
  Arch wiki https://wiki.archlinuxcn.org/wiki/首页
  Gentoo wiki https://wiki.gentoo.org/wiki/Main_Page
*/
{
  description = "FrdrCkII's NixOS and Nix Configurations with Flakes";
  nixConfig = {
    experimental-features = [
      "flakes"
      "nix-command"
      "ca-derivations"
    ];
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };
  inputs = {
    # 软件源
    # https://github.com/nixos/nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # 工具
    # https://github.com/nix-community/haumea
    haumea = {
      url = "github:nix-community/haumea/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # https://github.com/numtide/system-manager
    system-manager = {
      url = "github:numtide/system-manager/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # https://github.com/soupglasses/nix-system-graphics
    nix-system-graphics = {
      url = "github:soupglasses/nix-system-graphics/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nix框架
    # https://github.com/danth/stylix
    stylix = {
      url = "github:danth/stylix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 开发环境
    # https://github.com/oxalica/rust-overlay
    rust-overlay = {
      url = "github:oxalica/rust-overlay/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 我的NUR软件包
    FrdrCkII = {
      url = "path:./nix-pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { self, ... }@inputs:
    let
      inherit (inputs) haumea;
      inherit (inputs.nixpkgs) lib;
      custom-lib = import ./nix-lib { inherit lib; };
      config = haumea.lib.load {
        src = ./configurations;
        inputs = { inherit inputs lib custom-lib; };
      };
    in
    {
      nixosConfigurations = lib.attrsets.mergeAttrsList (
        lib.flatten (map (it: it.nixosConfigurations or { }) (lib.flatten (builtins.attrValues config)))
      );
      homeConfigurations = lib.attrsets.mergeAttrsList (
        lib.flatten (map (it: it.homeConfigurations or { }) (lib.flatten (builtins.attrValues config)))
      );
      systemConfigs = lib.attrsets.mergeAttrsList (
        lib.flatten (map (it: it.systemConfigs or { }) (lib.flatten (builtins.attrValues config)))
      );
    };
}
