{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./extra/gui.nix
      ./extra/dev.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-fc31de55-e874-4d20-8691-367b329dfb0d".device = "/dev/disk/by-uuid/fc31de55-e874-4d20-8691-367b329dfb0d";
  boot.initrd.luks.devices."luks-fc31de55-e874-4d20-8691-367b329dfb0d".keyFile = "/crypto_keyfile.bin";

  networking = {
    hostName = "taucetif";
    networkmanager.enable = true;
  };

  # Accounts (don't forget to set a password with 'passwd')
  #############################################################################

  environment.variables = {
    DEFAULT_USER = "earthling";
  };

  users.users.earthling = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Earthling";
    createHome = true;
    home = "/home/earthling";
    uid = 1000;
    extraGroups = [ "wheel" ];
  };

  users.users.powerless = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Capt. Powerless";
    createHome = true;
    home = "/home/powerless";
    uid = 1010;
  };

  # Locals
  #############################################################################

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.utf8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.utf8";
    LC_IDENTIFICATION = "de_DE.utf8";
    LC_MEASUREMENT = "de_DE.utf8";
    LC_MONETARY = "de_DE.utf8";
    LC_NAME = "de_DE.utf8";
    LC_NUMERIC = "de_DE.utf8";
    LC_PAPER = "de_DE.utf8";
    LC_TELEPHONE = "de_DE.utf8";
    LC_TIME = "de_DE.utf8";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  fonts.fonts = with pkgs; [
    powerline-fonts
  ];

  powerManagement.powertop.enable = true;
  security.sudo.enable = true;

  # Program configuration
  #############################################################################

  programs.git = {
    enable = true;
    lfs.enable = true;
    config = {
      fetch = { prune = true; };
    };
  };

  programs.htop.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''
        set nocompatible
        syntax on
        set foldmethod=syntax
        set nu
        filetype indent plugin on
      '';
    };
    withPython3 = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    newSession = true;
  };

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "helm" "kubectl"];
      theme = "robbyrussell";
    };
  };


  # Packages and environment
  #############################################################################

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    gh            # GitHub CLI
    tig           # text-mode interface for git
    bat           # cat clone with syntax highlighting and Git integration
    glow          # render markdown on the CLI
    curl          # you shouldknow
    xh            # friendly and fast tool for sending HTTP requests
    bitwarden-cli # secure and free password manager
    tree
  ];


  # Services
  #############################################################################

  services.earlyoom = {
    enable = true;
    enableNotifications = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    jack.enable = true;
    pulse.enable = true;
  };

  services.fwupd.enable = true;
  services.openssh.enable = true;
  services.printing.enable = true;


  # Misc
  #############################################################################

  hardware.pulseaudio.enable = false;
  sound.enable = true;

  system.stateVersion = "unstable";
}
