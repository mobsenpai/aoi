self: {
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.services.aoi;
in {
  options.services.aoi = {
    enable = mkEnableOption "aoi";
    pathfix = mkEnableOption "LUA_CPATH path fix"; # TODO: remove once fixed
    systemd = mkEnableOption "systemd service";
  };

  config = mkIf cfg.enable {
    home.packages = [
      self.packages.${pkgs.system}.default
      self.inputs.astal.packages.${pkgs.system}.default
    ];

    # home.sessionVariables.LUA_CPATH = mkIf cfg.pathfix "${pkgs.luaPackages.getLuaCPath pkgs.luaPackages.luautf8}";

    systemd.user.services.aoi = mkIf cfg.systemd {
      Unit = {
        Description = "aoi";
        After = ["graphical-session.target"];
      };
      Service = {
        Type = "simple";
        ExecStart = "${self.packages.${pkgs.system}.default}/bin/aoi";
        # TODO: remove after fix
        Environment = mkIf cfg.pathfix [
          "LUA_CPATH=${pkgs.luaPackages.getLuaCPath pkgs.luaPackages.luautf8}"
        ];
        Restart = "on-failure";
        RestartSec = "1s";
        TimeoutStopSec = "10s";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
