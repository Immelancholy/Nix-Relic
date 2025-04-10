{
  security.rtkit = {
    enable = true;
    args = [
      "--our-realtime-priority=90"
      "--max-realtime-priority=89"
      "--threads-per-user-max=16"
    ];
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    audio.enable = true;
    wireplumber = {
      enable = true;
    };
  };
  services.pipewire.extraConfig.pipewire."91-null-sinks" = {
    "context.modules" = [
      {
        # properyty when no other driver is currently active. JACK clients need this.
        name = "libpipewire-module-loopback";
        args = {
          "audio.position" = "[FL, FR]";
          "capture.props" = {
            "node.name" = "dummy_plug_in";
            "node.description" = "Dummy Plug In";
            "media.class" = "Audio/Sink";
          };
          "playback.props" = {
            "node.name" = "dummy_plug_out";
            "node.description" = "Dummy Plug Out";
            "media.class" = "Audio/Source";
          };
        };
      }
      {
        # properyty when no other driver is currently active. JACK clients need this.
        name = "libpipewire-module-loopback";
        args = {
          "audio.position" = "[FL, FR]";
          "capture.props" = {
            "node.name" = "commes_mic_in";
            "node.description" = "Commes Mic In";
            "node.target" = "easyeffects_source";
            "media.class" = "Audio/Sink";
          };
          "playback.props" = {
            "node.name" = "commes_mic_out";
            "node.description" = "Commes Mic Out";
            "media.class" = "Audio/Source";
          };
        };
      }
      {
        # properyty when no other driver is currently active. JACK clients need this.
        name = "libpipewire-module-loopback";
        args = {
          "audio.position" = "[FL, FR]";
          "capture.props" = {
            "node.name" = "desktop_mic_in";
            "node.description" = "Desktop Mic In";
            "node.target" = "easyeffects_source";
            "media.class" = "Audio/Sink";
          };
          "playback.props" = {
            "node.name" = "desktop_mic_out";
            "node.description" = "Desktop Mic Out";
            "media.class" = "Audio/Source";
          };
        };
      }
      {
        # properyty when no other driver is currently active. JACK clients need this.
        name = "libpipewire-module-loopback";
        args = {
          "audio.position" = "[FL, FR]";
          "capture.props" = {
            "node.name" = "virtual_cable_in";
            "node.description" = "Virtual Cable In";
            "media.class" = "Audio/Sink";
          };
          "playback.props" = {
            "node.name" = "virtual_cable_out";
            "node.description" = "Virtual Cable Out";
            "media.class" = "Audio/Source";
          };
        };
      }
      {
        # properyty when no other driver is currently active. JACK clients need this.
        name = "libpipewire-module-loopback";
        args = {
          "audio.position" = "[FL, FR]";
          "capture.props" = {
            "node.name" = "virtual_cable_b_in";
            "node.description" = "Virtual Cable B In";
            "media.class" = "Audio/Sink";
          };
          "playback.props" = {
            "node.name" = "virtual_cable_b_out";
            "node.description" = "Virtual Cable B Out";
            "media.class" = "Audio/Source";
          };
        };
      }
    ];
    "context.objects" = [
      {
        # A default dummy driver. This handles nodes marked with the "node.always-driver"
        # properyty when no other driver is currently active. JACK clients need this.
        factory = "spa-node-factory";
        args = {
          "factory.name" = "support.node.driver";
          "node.name" = "Dummy-Driver";
          "priority.driver" = 8000;
        };
      }
      {
        # properyty when no other driver is currently active. JACK clients need this.
        factory = "adapter";
        args = {
          "factory.name" = "support.null-audio-sink";
          "node.name" = "commes_output";
          "node.description" = "Commes Output";
          "media.class" = "Audio/Sink";
          "audio.position" = "[FL, FR]";
          "monitor.channel-volumes" = "true";
          "monitor.passthrough" = "true";
          "adapter.auto-port-config" = {
            "mode" = "dsp";
            "monitor" = "true";
            "position" = "preserve";
          };
        };
      }
      {
        # properyty when no other driver is currently active. JACK clients need this.
        factory = "adapter";
        args = {
          "factory.name" = "support.null-audio-sink";
          "node.name" = "desktop_output";
          "node.description" = "Desktop Output";
          "media.class" = "Audio/Sink";
          "audio.position" = "[FL, FR]";
          "monitor.channel-volumes" = "true";
          "monitor.passthrough" = "true";
          "adapter.auto-port-config" = {
            "mode" = "dsp";
            "monitor" = "true";
            "position" = "preserve";
          };
        };
      }
    ];
  };
  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    "context.properties" = {
      "default.clock.allowed-rates" = [44100 48000 88200 96000];
      "default.clock.min-quantum" = 64;
      "default.clock.max-quantum" = 512;
      "default.clock.quantum-limit" = 4096;
      "default.clock.quantum-floor" = 32;
    };
  };
  services.pipewire.extraConfig.jack."92-low-latency" = {
    "jack.properties" = {
      "rt.prio" = 88;
      "node.latency" = "256/96000";
      "node.rate" = "1/96000";
      "node.quantum" = "256/96000";
      "node.force-quantum" = 256;
    };
  };
  services.pipewire.extraConfig.client."92-low-latency" = {
    "stream.properties" = {
      "resample.quality" = 15;
    };
  };
  services.pipewire.extraConfig.pipewire-pulse."92-low-latency" = {
    "context.properties" = [
      {
        name = "libpipewire-module-protocol-pulse";
        args = {};
      }
    ];
    "pulse.properties" = {
      "pulse.min.req" = "64/48000";
      "pulse.default.req" = "128/48000";
      "pulse.max.req" = "512/48000";
      "pulse.min.quantum" = "64/48000";
      "pulse.max.quantum" = "512/48000";
    };
    "stream.properties" = {
      "node.latency" = "32/48000";
      "resample.quality" = 1;
    };
  };
}
