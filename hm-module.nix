self: {
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.aoi;
in {
  options.programs.aoi = {
    enable = lib.mkEnableOption "aoi";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [self.packages.${pkgs.system}.default];
  };
}
