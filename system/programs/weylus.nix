{user, ...}: {
  programs.weylus = {
    enable = true;
    users = [
      "${user}"
    ];
    openFirewall = true;
  };
}
