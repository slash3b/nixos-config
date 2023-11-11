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

	jack.enable = true;
  };

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

  services.tailscale = {
  	enable = true;
  };

  services.syncthing = {
        enable = true;
        user = "slash3b";
        dataDir = "/home/slash3b/Documents";    # Default folder for new synced folders
        configDir = "/home/slash3b/Documents/.config/syncthing";   # Folder for Syncthing's settings and keys
    };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.slash3b = {
    isNormalUser = true;
    description = "Ilya";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [
    ];
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

	home.stateVersion = "23.05";

	home.packages = with pkgs; [
		# like a redshift
		go-sct
		neovim
		firefox
		# modern grep
		ripgrep
		go
		# terminal multiplexer
		tmux
		_1password
		_1password-gui
		neofetch
		# amazing magical thing
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
		slack
		zoom-us

		# dev
		# postman

		feh
		# gpg2
        # todo: configure this and other programs properly
		gnupg1
        fzf

        # json
        jq

        wget
        zip
        unzip

        # pdf
        evince

        vscode
	];

	home.file = {
		".tmux.conf".source = ./sources/.tmux.conf;
		".gitconfig".source = ./sources/.gitconfig;
		".gitignore".source = ./sources/.gitignore;
		".alacritty.yml".source = ./sources/.alacritty.yml;
		".config/fish/config.fish".source = ./sources/config.fish;
		".vimrc".source = ./sources/.vimrc;
		".config/nvim/init.vim".source = ./sources/init.vim;

		".config/i3" = {
			source = ./sources/i3;
			recursive = true;
		};
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
	# compositor, whatever this means, makes everything smooooth
	picom

	# if installed like this, this will be more distro agnostic way to manager dotfiles
	# see: https://www.youtube.com/watch?v=FcC2dzecovw
  	# home-manager
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
