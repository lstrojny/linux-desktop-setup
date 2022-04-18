{ pkgs, ... }: {
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment with Wayland
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;
  hardware.opengl.enable = true;
  # services.xserver.libinput.enable = true;

  programs.gnome-terminal.enable = true;
  fonts = {
    fonts = with pkgs; [ fira-code fira-code-symbols joypixels powerline-fonts ];
    fontconfig.defaultFonts.monospace = [ "Fira Code Medium" ];
    fontconfig.defaultFonts.emoji = [ "JoyPixels" ];
  };
}
