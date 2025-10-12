{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;

    wireplumber.extraConfig."10-bluez" = {
      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = true;
        "bluez5.enable-aac" = true;
        "bluez5.enable-aptx" = true;
        "bluez5.enable-aptx-hd" = true;
        "bluez5.enable-ldac" = true;
        "bluez5.a2dp.assume-no-resampling" = true;
        "bluez5.default-profile" = "a2dp-sink";
        "bluez5.roles" = [
          "a2dp_sink"
          "a2dp_source"
          "hsp_hs"
          "hsp_ag"
          "hfp_hf"
          "hfp_ag"
        ];

        "bluez5.codecs" = [
          "ldac"
          "aptx_hd"
          "aptx"
          "aac"
          "sbc_xq"
          "sbc"
        ];
      };
    };
  };

  security.rtkit.enable = true;
  systemd.user.services.pipewire = {
    serviceConfig = {
      TimeoutStopSec = 5;
      Restart = "always";
      RestartSec = 2;
    };
  };
}
