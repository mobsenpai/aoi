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
      extraPackages = [
        astal.packages.${system}.battery
        pkgs.dart-sass
        astal.packages.${system}.hyprland # For AstalHyprland
        astal.packages.${system}.tray # For AstalTray
        astal.packages.${system}.astal3
        astal.packages.${system}.wireplumber
        astal.packages.${system}.notifd
        pkgs.glib
        pkgs.lua52Packages.luautf8
      ];
    };

    homeModules.default = import ./hm-module.nix self;
  };
}
