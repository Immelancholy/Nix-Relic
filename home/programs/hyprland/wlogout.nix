{ lib, ... }: {
  programs.wlogout = {
    enable = true;
    layout = lib.mkDefault [
      {
        label = "lock";
        action = "swaylock-fancy";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "logout";
        action = "loginctl terminate-user $USER";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];
    style = ''
* {
	background-image: none;
	box-shadow: none;
}

window {
	background-color: rgba(30, 30, 46, 0.90);
}

button {
	border-radius: 0;
	border-color: #cba6f7;
	text-decoration-color: #cdd6f4;
	color: #cdd6f4;
	background-color: #181825;
	border-style: solid;
	border-width: 1px;
	background-repeat: no-repeat;
	background-position: center;
	background-size: 25%;
}

button:focus, button:active, button:hover {
	/* 20% Overlay 2, 80% mantle */
	background-color: rgb(48, 50, 66);
	outline-style: none;
}
    '';
  };
}
