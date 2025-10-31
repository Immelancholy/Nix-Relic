{
  services.easyeffects = {
    enable = true;
    preset = "Rode-NT1";
    extraPresets = {
      Rode-NT1 = {
        input = {
          "bass_enhancer#0" = {
            "amount" = 3.0;
            "blend" = 4.0;
            "bypass" = false;
            "floor" = 20.0;
            "floor-active" = true;
            "harmonics" = 8.5;
            "input-gain" = 0.0;
            "output-gain" = 0.0;
            "scope" = 200.0;
          };
          "blocklist" = [];
          "compressor#0" = {
            "attack" = 30.020000000000003;
            "boost-amount" = 6.0;
            "boost-threshold" = -72.0;
            "bypass" = false;
            "dry" = -100.0;
            "hpf-frequency" = 200.0;
            "hpf-mode" = "24 dB/oct";
            "input-gain" = 0.0;
            "knee" = -9.0;
            "lpf-frequency" = 16000.0;
            "lpf-mode" = "24 dB/oct";
            "makeup" = 6.0;
            "mode" = "Downward";
            "output-gain" = 0.0;
            "ratio" = 3.0;
            "release" = 20.0;
            "release-threshold" = -100.0;
            "sidechain" = {
              "lookahead" = 0.0;
              "mode" = "RMS";
              "preamp" = 6.0;
              "reactivity" = 10.0;
              "source" = "Middle";
              "stereo-split-source" = "Left/Right";
              "type" = "Feed-back";
            };
            "stereo-split" = true;
            "threshold" = -6.0;
            "wet" = 0.0;
          };
          "deesser#0" = {
            "bypass" = false;
            "detection" = "RMS";
            "f1-freq" = 5000.0;
            "f1-level" = 0.0;
            "f2-freq" = 4500.0;
            "f2-level" = 12.0;
            "f2-q" = 1.0;
            "input-gain" = 0.0;
            "laxity" = 15;
            "makeup" = 0.0;
            "mode" = "Wide";
            "output-gain" = 0.0;
            "ratio" = 3.0;
            "sc-listen" = false;
            "threshold" = -35.0;
          };
          "gate#0" = {
            "attack" = 20.0;
            "bypass" = false;
            "curve-threshold" = -56.0;
            "curve-zone" = -6.0;
            "dry" = -100.0;
            "hpf-frequency" = 10.0;
            "hpf-mode" = "off";
            "hysteresis" = false;
            "hysteresis-threshold" = -12.0;
            "hysteresis-zone" = -6.0;
            "input-gain" = 0.0;
            "lpf-frequency" = 20000.0;
            "lpf-mode" = "off";
            "makeup" = 0.0;
            "output-gain" = 0.0;
            "reduction" = -24.0;
            "release" = 99.99;
            "sidechain" = {
              "input" = "Internal";
              "lookahead" = 0.0;
              "mode" = "RMS";
              "preamp" = 0.0;
              "reactivity" = 10.0;
              "source" = "Middle";
              "stereo-split-source" = "Left/Right";
            };
            "stereo-split" = false;
            "wet" = -0.7999999999999999;
          };
          "plugins_order" = [
            "rnnoise#0"
            "gate#0"
            "deesser#0"
            "compressor#0"
            "bass_enhancer#0"
            "reverb#0"
          ];
          "reverb#0" = {
            "amount" = -25.0;
            "bass-cut" = 257.65;
            "bypass" = false;
            "decay-time" = 0.445945;
            "diffusion" = 0.54;
            "dry" = 0.0;
            "hf-damp" = 5508.46;
            "input-gain" = 0.0;
            "output-gain" = 0.0;
            "predelay" = 25.0;
            "room-size" = "Small";
            "treble-cut" = 20000.0;
          };
          "rnnoise#0" = {
            "bypass" = false;
            "enable-vad" = false;
            "input-gain" = 0.0;
            "model-name" = "";
            "output-gain" = 0.0;
            "release" = 20.0;
            "vad-thres" = 50.0;
            "wet" = 0.0;
          };
        };
      };
      ATH-R70x = {
        "output" = {
          "blocklist" = [
            "Zen"
          ];
          "equalizer#0" = {
            "balance" = 0.0;
            "bypass" = false;
            "input-gain" = -10.22;
            "left" = {
              "band0" = {
                "frequency" = 105.0;
                "gain" = 13.399999618530273;
                "mode" = "APO (DR)";
                "mute" = false;
                "q" = 0.6666666865348816;
                "slope" = "x1";
                "solo" = false;
                "type" = "Lo-shelf";
                "width" = 4.0;
              };
              "band1" = {
                "frequency" = 42.599998474121094;
                "gain" = -3.0;
                "mode" = "APO (DR)";
                "mute" = false;
                "q" = 0.7699999809265137;
                "slope" = "x1";
                "solo" = false;
                "type" = "Bell";
                "width" = 4.0;
              };
              "band2" = {
                "frequency" = 74.4000015258789;
                "gain" = -7.099999904632568;
                "mode" = "APO (DR)";
                "mute" = false;
                "q" = 0.44999998807907104;
                "slope" = "x1";
                "solo" = false;
                "type" = "Bell";
                "width" = 4.0;
              };
              "band3" = {
                "frequency" = 2168.699951171875;
                "gain" = -1.2000000476837158;
                "mode" = "APO (DR)";
                "mute" = false;
                "q" = 1.0199999809265137;
                "slope" = "x1";
                "solo" = false;
                "type" = "Bell";
                "width" = 4.0;
              };
              "band4" = {
                "frequency" = 3178.699951171875;
                "gain" = 1.100000023841858;
                "mode" = "APO (DR)";
                "mute" = false;
                "q" = 5.46999979019165;
                "slope" = "x1";
                "solo" = false;
                "type" = "Bell";
                "width" = 4.0;
              };
              "band5" = {
                "frequency" = 3514.800048828125;
                "gain" = -3.700000047683716;
                "mode" = "APO (DR)";
                "mute" = false;
                "q" = 3.490000009536743;
                "slope" = "x1";
                "solo" = false;
                "type" = "Bell";
                "width" = 4.0;
              };
              "band6" = {
                "frequency" = 4475.60009765625;
                "gain" = 4.800000190734863;
                "mode" = "APO (DR)";
                "mute" = false;
                "q" = 1.1799999475479126;
                "slope" = "x1";
                "solo" = false;
                "type" = "Bell";
                "width" = 4.0;
              };
              "band7" = {
                "frequency" = 4644.2998046875;
                "gain" = 0.10000000149011612;
                "mode" = "APO (DR)";
                "mute" = false;
                "q" = 0.8100000023841858;
                "slope" = "x1";
                "solo" = false;
                "type" = "Bell";
                "width" = 4.0;
              };
              "band8" = {
                "frequency" = 9110.2998046875;
                "gain" = 2.799999952316284;
                "mode" = "APO (DR)";
                "mute" = false;
                "q" = 1.7200000286102295;
                "slope" = "x1";
                "solo" = false;
                "type" = "Bell";
                "width" = 4.0;
              };
              "band9" = {
                "frequency" = 10000.0;
                "gain" = -1.7999999523162842;
                "mode" = "APO (DR)";
                "mute" = false;
                "q" = 0.6666666865348816;
                "slope" = "x1";
                "solo" = false;
                "type" = "Hi-shelf";
                "width" = 4.0;
              };
            };
            "mode" = "IIR";
            "num-bands" = 10;
            "output-gain" = 0.0;
            "pitch-left" = 0.0;
            "pitch-right" = 0.0;
            "right" = {
              "band0" = {
                "frequency" = 105.0;
                "gain" = 13.399999618530273;
                "mode" = "APO (DR)";
                "mute" = false;
                "q" = 0.6666666865348816;
                "slope" = "x1";
                "solo" = false;
                "type" = "Lo-shelf";
                "width" = 4.0;
              };
              "band1" = {
                "frequency" = 42.599998474121094;
                "gain" = -3.0;
                "mode" = "APO (DR)";
                "mute" = false;
                "q" = 0.7699999809265137;
                "slope" = "x1";
                "solo" = false;
                "type" = "Bell";
                "width" = 4.0;
              };
              "band2" = {
                "frequency" = 74.4000015258789;
                "gain" = -7.099999904632568;
                "mode" = "APO (DR)";
                "mute" = false;
                "q" = 0.44999998807907104;
                "slope" = "x1";
                "solo" = false;
                "type" = "Bell";
                "width" = 4.0;
              };
              "band3" = {
                "frequency" = 2168.699951171875;
                "gain" = -1.2000000476837158;
                "mode" = "APO (DR)";
                "mute" = false;
                "q" = 1.0199999809265137;
                "slope" = "x1";
                "solo" = false;
                "type" = "Bell";
                "width" = 4.0;
              };
              "band4" = {
                "frequency" = 3178.699951171875;
                "gain" = 1.100000023841858;
                "mode" = "APO (DR)";
                "mute" = false;
                "q" = 5.46999979019165;
                "slope" = "x1";
                "solo" = false;
                "type" = "Bell";
                "width" = 4.0;
              };
              "band5" = {
                "frequency" = 3514.800048828125;
                "gain" = -3.700000047683716;
                "mode" = "APO (DR)";
                "mute" = false;
                "q" = 3.490000009536743;
                "slope" = "x1";
                "solo" = false;
                "type" = "Bell";
                "width" = 4.0;
              };
              "band6" = {
                "frequency" = 4475.60009765625;
                "gain" = 4.800000190734863;
                "mode" = "APO (DR)";
                "mute" = false;
                "q" = 1.1799999475479126;
                "slope" = "x1";
                "solo" = false;
                "type" = "Bell";
                "width" = 4.0;
              };
              "band7" = {
                "frequency" = 4644.2998046875;
                "gain" = 0.10000000149011612;
                "mode" = "APO (DR)";
                "mute" = false;
                "q" = 0.8100000023841858;
                "slope" = "x1";
                "solo" = false;
                "type" = "Bell";
                "width" = 4.0;
              };
              "band8" = {
                "frequency" = 9110.2998046875;
                "gain" = 2.799999952316284;
                "mode" = "APO (DR)";
                "mute" = false;
                "q" = 1.7200000286102295;
                "slope" = "x1";
                "solo" = false;
                "type" = "Bell";
                "width" = 4.0;
              };
              "band9" = {
                "frequency" = 10000.0;
                "gain" = -1.7999999523162842;
                "mode" = "APO (DR)";
                "mute" = false;
                "q" = 0.6666666865348816;
                "slope" = "x1";
                "solo" = false;
                "type" = "Hi-shelf";
                "width" = 4.0;
              };
            };
            "split-channels" = false;
          };
          "plugins_order" = [
            "equalizer#0"
          ];
        };
      };
    };
  };
}
