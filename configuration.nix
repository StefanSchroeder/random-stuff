{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "thinkpad";
  networking.wireless.enable = true;
  time.timeZone = "Europe/Berlin";

  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;
  networking.interfaces.wwp0s29u1u4i6.useDHCP = true;

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
  services.xserver.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
	  "xpdf-4.02"
  ];
  services.xserver.displayManager.defaultSession = "xfce";
  services.xserver.desktopManager.xfce.enable = true;
  #services.xserver.windowManager.openbox.enable = true;
  services.printing.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.layout = "de";
  services.avahi.nssmdns = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  services.xserver.libinput.enable = true;

  users.users.horst = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; 
  };


  environment.systemPackages = with pkgs; [
    alacritty
    arc-theme
    brave
    dropbox
    evince
    file 
    firefox 
    font-manager
    git 
    glxinfo
    gnumake
    go
    gparted
    htop
    inkscape
    inxi
    jgmenu
    keepassxc
    less 
    libreoffice
    lxappearance
    lxmenu-data
    mc 
    menumaker
    mtools 
    nix-index
    nixui
    obconf
    openbox
    openbox-menu
    pandoc
    papirus-icon-theme
    pdftk
    python38
    rofi
    skype
    tectonic 
    texlive.combined.scheme-full
    thunderbird
    usbutils
    vim 
    vlc
    wget 
    xdgmenumaker
    xclip
    xfce.xfce4-battery-plugin
    xfce.xfce4-datetime-plugin
    xfce.xfce4-power-manager
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-xkb-plugin
    zathura
    zoom-us
  ];

  services.openssh.enable = true;

  system.stateVersion = "20.09"; # Did you read the comment?

}
