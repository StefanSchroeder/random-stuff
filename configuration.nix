# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "thinkpad"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;
  networking.interfaces.wwp0s29u1u4i6.useDHCP = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

fonts.fonts = with pkgs; [
	fira-code
	google-fonts
	gyre-fonts
	fira-code-symbols
	liberation_ttf
	libertine
	libertinus
	proggyfonts
	caladea
	corefonts
	gentium
	go-font
	libre-caslon
	penna
	ubuntu_font_family
	vistafonts
	yanone-kaffeesatz
	lmodern
];

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  nixpkgs.config.permittedInsecurePackages = [
	  "xpdf-4.02"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    arc-theme
    dropbox
    evince
    file 
    firefox 
    font-manager
    git 
    glxinfo
    go
    gparted
    htop
    inkscape
    inxi
    jgmenu
    keepassxc
    less 
    libreoffice
usbutils
    lxappearance
lxmenu-data
    mc 
    mtools 
    nix-index
    nixui
    obconf
    openbox
    openbox-menu
menumaker
xdgmenumaker
    pandoc
    papirus-icon-theme
    pdftk
    psutils
python38
    skype
    tectonic 
    texlive.combined.scheme-full
    thunderbird
    vim 
    vlc
    wget 
    xfce.xfce4-battery-plugin
    xfce.xfce4-datetime-plugin
    xfce.xfce4-power-manager
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-xkb-plugin
    zathura
    zoom-us
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "de";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  #services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  services.xserver.windowManager.openbox.enable = true;
  services.xserver.displayManager.defaultSession =  "none+openbox";

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.horst = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
   };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}
