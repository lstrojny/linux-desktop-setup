{
  networking.hostName = "hackstrojny";
  networking.hostId = "24041986";
  networking.enableIPv6 = true;
  networking.wireless.enable = false;

  networking.useDHCP = false;
  networking.interfaces.enp6s0.useDHCP = true;
  networking.interfaces.enp9s0.useDHCP = true;

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      hinfo = true;
      workstation = true;
    };
  };
}
