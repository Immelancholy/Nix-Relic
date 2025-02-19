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
          "audio.position" = "FL, FR";
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
          "audio.position" = "FL, FR";
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
          "node.name" = "virtual_cable";
          "node.description" = "Virtual Cable";
          "media.class" = "Audio/Sink";
          "audio.position" = "FL, FR";
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
          "node.name" = "virtual_cable_b";
          "node.description" = "Virtual Cable B";
          "media.class" = "Audio/Sink";
          "audio.position" = "FL, FR";
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
          "node.name" = "desktop_input";
          "node.description" = "Desktop Input";
          "media.class" = "Audio/Source/Virtual";
          "audio.position" = "FL, FR";
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
          "node.name" = "commes_input";
          "node.description" = "Commes Input";
          "media.class" = "Audio/Source/Virtual";
          "audio.position" = "FL, FR";
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
          "node.name" = "dummy_plug";
          "node.description" = "Dummy Plug";
          "node.virtual" = "true";
          "media.class" = "Audio/Source/Virtual";
          "audio.position" = "FL, FR";
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
      "default.clock.max-quantum" = 128;
      "default.clock.quantum-limit" = 4096;
      "default.clocl.quantum-floor" = 32;
    };
  };
  services.pipewire.extraConfig.jack."92-low-latency" = {
    "jack.properties" = {
      "node.latency" = "256/96000";
      "node.rate" = "1/96000";
      "node.quantum" = "256/96000";
      "node-force-quantum" = 256;
    };
  };
  services.pipewire.extraConfig.client."92-low-latency" = {
    "stream.properties" = {
      "resample.quality" = 15;
    };
  };
}
