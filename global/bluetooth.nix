{ pkgs, ... }: {
  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;
}
