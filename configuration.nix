# Edit this configuration file to define what should be installed on # your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
    	# Include the results of the hardware scan.
	./hardware-configuration.nix
	<home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "Xtal"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Chisinau";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    enable = true;
    autorun = true;
    dpi = 144;

    desktopManager = {
	xterm.enable = false;
	wallpaper.mode = "fill";
    };

    displayManager = {
	defaultSession = "none+i3";
	lightdm.enable = true;

        autoLogin = {
	  user = "slash3b";
          enable = true;
        };
    };

    windowManager = {
	i3.enable = true;
    };
  };


  services.picom = {
    enable = true;
    vSync = true;
  };

  services.redshift = {
  	enable = true;
	brightness = {
	  day = "1";
	  night = "1";
	};
	temperature = {
	  night = 3700;
	};

/*
	config.location {
	  provider = "manual";
	  latitude = "47.01";
	  longitude = "28.86";
	};
	*/
  };



  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.slash3b = {
    isNormalUser = true;
    description = "Ilya";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
	vim
	neovim
	firefox
	alacritty
	ripgrep
	go
	tmux
	_1password
	_1password-gui
	neofetch
	git
	redshift
	picom
    ];
  };


  home-manager.users.slash3b = { pkgs, ... }: {
	home.packages = [
		pkgs.tree
	];
	home.stateVersion = "23.05";
  };
  #home-manager.users.slash3b.home.stateVersion

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	vim
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true; # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
