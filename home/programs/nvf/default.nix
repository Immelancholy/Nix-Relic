{pkgs, inputs, ...}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        autocomplete.blink-cmp.enable = true;
      };
    };
  };
}
