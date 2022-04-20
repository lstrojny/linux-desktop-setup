{ settings, ... }:
with settings.identity; {
  users.mutableUsers = false;
  users.users."${nick}" = {
    isNormalUser = true;
    createHome = true;
    home = "/home/${nick}";
    description = name;
    extraGroups = [ "wheel" "networkmanager" ];
    hashedPassword =
      "$6$3wh8GiYYOgFm321d$8CXIw54QA8FrrbbQB/XtIMUQq11CFVPzvMwg1vdDgW7bTFd92i6pihw9JQR2nqQfinCpK0dVgdRp7XuazWvaL.";
  };
  security.sudo.wheelNeedsPassword = false;
}
