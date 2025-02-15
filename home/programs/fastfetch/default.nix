{
	programs.fastfetch = {
		enable = true;
		settings = {
			logo = {
				source = "$HOME/mela/Pictures/tomoe.png";
				height = 18;
			};
			display = {
				separator = " : ";
			};
			modules = [
				{
					type = "command";
					key = "  ";
					keyColor = "blue";

				}
				{
					type = "custom";
					format = "┌──────────────────────────────────────────┐";
				}
				{
					type = "chassis";
					key = "  󰇺 Chassis";
					format = "{1} {2} {3}";
				}
				{
					type = "os";
					key = "   OS";
					format = "{2}";
					keyColor = "red";
				}
				"break"
			];
		};
	};
}
