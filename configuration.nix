# Edit this configuration file to define what should be installed on # your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
    	# Include the results of the hardware scan.
	./hardware-configuration.nix

	# add home-manager as NixOS module
	# see: https://nix-community.github.io/home-manager/index.html#sec-install-nixos-module
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

  services.pipewire = {
	enable = true;
	audio.enable = true;
	pulse.enable = true;

	alsa = {
		enable = true;
		support32Bit = true;
	};

	# jack.enable = true;
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;

    layout = "us";
    autorun = true;
    dpi = 144;

    desktopManager = {
        xterm.enable = false;
        wallpaper.mode = "fill";
    };

    displayManager = {
        lightdm.enable = true;

        defaultSession = "none+i3";

        autoLogin = {
            user = "slash3b";
            enable = true;
        };
    };

    videoDrivers = [ "amdgpu" ];

    windowManager = {
	    i3.enable = true;
    };
  };


  services.picom = {
    enable = true;
    vSync = true;
  };

  services.tailscale = {
  	enable = true;
  };

  services.syncthing = {
        enable = true;
        user = "slash3b";
        dataDir = "/home/slash3b/Documents";    # Default folder for new synced folders
        configDir = "/home/slash3b/Documents/.config/syncthing";   # Folder for Syncthing's settings and keys
  };

  # Define a user account. Don't forget to set a password with ‘passwd’
  users.users.slash3b = {
    isNormalUser = true;
    description = "Ilya";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker"];
        packages = with pkgs; [];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #
  # By default, Home Manager uses a private pkgs instance 
  # that is configured via the home-manager.users.<name>.nixpkgs options. 
  #
  # To instead use the global pkgs that is configured via the system level nixpkgs options, 
  # set `home-manager.useGlobalPkgs = true;`
  #
  home-manager.useGlobalPkgs = true;
  home-manager.users.slash3b = { pkgs, nixpkgs, ... }: {

	# with useGlobalPkgs enabled, this is not needed, just comment out for now
	# nixpkgs.config.allowUnfree = true;

	home.stateVersion = "23.11";


  home.packages = with pkgs; [
	neovim
	firefox
	# modern grep
	ripgrep
	# terminal multiplexer
	tmux

	_1password
	_1password-gui
	neofetch

	tailscale

	transmission
	xfce.thunar
	vlc
	fish
	htop
	rofi
	gnumake
	xfce.xfce4-screenshooter

	# just to be able to control volume throug pactl ?
	pulseaudio

	# system tools
	pciutils
	file

	# chats
	# zoom-us

	# dev
	# postman

	feh
	# gpg2
        # todo: configure this and other programs properly

		#gnupg1
        # pinentry

        fzf

        # json
        jq

        wget
        zip
        unzip

        # pdf
        evince

        vscode

        # Collection of common network programs
        inetutils

        # direnv – unclutter your .profile
        direnv

        # coreutils

        # i3
        lxappearance

        # docker
        ctop

        autorandr
        caffeine-ng
    ];

  programs.gpg = {
      enable = true;
  };
  # todo: learn how to import/export GPG keys
  # and figure out storage
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "tty";

    # cache the keys forever so we don't get asked for a password
    defaultCacheTtl = 31536000;
    maxCacheTtl = 31536000;
  };

	home.file = {
		".tmux.conf".source = ./sources/.tmux.conf;
		".gitconfig".source = ./sources/.gitconfig;
		".gitconfig.work".source = ./sources/.gitconfig.work;
		".gitignore".source = ./sources/.gitignore;
		".alacritty.yml".source = ./sources/.alacritty.yml;
		".config/fish/config.fish".source = ./sources/config.fish;
		".vimrc".source = ./sources/.vimrc;
		".config/nvim/init.vim".source = ./sources/init.vim;

		".config/i3" = {
			source = ./sources/i3;
			recursive = true;
		};
        ".ssh/config".source = ./sources/.ssh/config;
	};
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	vim
	tree
	# terminal
	alacritty
	git

	# ui to connect to wifi
    networkmanagerapplet
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
  # services.openssh.settings.PasswordAuthentication = true;
  # services.openssh.settings.PermitRootLogin = "no";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
