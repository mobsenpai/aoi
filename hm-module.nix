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
    colors = lib.mkOption {
      type = lib.types.attrs;
      default = {
        bg0 = "282828"; # main background
        bg1 = "3c3836";
        bg2 = "504945";
        bg3 = "665c54";
        bg4 = "7c6f64";

        fg0 = "fbf1c7";
        fg1 = "ebdbb2"; # main foreground
        fg2 = "d5c4a1";
        fg3 = "bdae93";
        fg4 = "a89984"; # gray0

        gray0 = "a89984";
        gray1 = "928374";

        red0 = "cc241d"; # neutral
        red1 = "fb4934"; # bright
        green0 = "98971a";
        green1 = "b8bb26";
        yellow0 = "d79921";
        yellow1 = "fabd2f";
        blue0 = "458588";
        blue1 = "83a598";
        purple0 = "b16286";
        purple1 = "d3869b";
        aqua0 = "689d6a";
        aqua1 = "8ec07c";
        orange0 = "d65d0e";
        orange1 = "fe8019";
      };
      description = "Attribute set of colors";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [self.packages.${pkgs.system}.default];
    xdg.configFile."astal/scss/themes/astel.scss".text = ''
      $ac-red: #${config.programs.astal.colors.blue1};
      $ac-green: #AAF9B0;
      $ac-yellow: #F9F7AA;
      $ac-blue: #A8C7FA;
      $ac-magenta: #DCADF9;
      $ac-cyan: #AAF3F9;
      $ac-orange: #F9C5AA;
      $bg: #171719;
      $bg-alt: #252628;
      $bg-urg: #3A3A3D;
      $fg-alt: #6E6E72;
      $fg: #E5E7ED;
      $ac: $ac-blue;
    '';
  };
}
