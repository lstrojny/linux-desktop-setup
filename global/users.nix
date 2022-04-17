{ settings, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.lstrojny = {
    isNormalUser = true;
    createHome = true;
    home = "/home/lstrojny";
    description = settings.name;
    extraGroups = [ "wheel" "networkmanager" ];
    hashedPassword =
      "$6$3wh8GiYYOgFm321d$8CXIw54QA8FrrbbQB/XtIMUQq11CFVPzvMwg1vdDgW7bTFd92i6pihw9JQR2nqQfinCpK0dVgdRp7XuazWvaL.";
  };
  security.sudo.wheelNeedsPassword = false;
}
