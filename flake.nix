{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    astal,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system}.default = astal.lib.mkLuaPackage {
      inherit pkgs;
      name = "aoi"; # how to name the executable
      src = ./.; # should contain init.lua

      # add extra glib packages or binaries
      extraPackages = with astal.packages.${system};
        [
          battery
          hyprland
          tray
          astal3
          wireplumber
          notifd
        ]
        ++ (with pkgs; [
          dart-sass
        ])
        ++ (with pkgs.lua52Packages; [
          cjson
          luautf8
        ]);
    };

    homeModules.default = import ./hm-module.nix self;
  };
}
