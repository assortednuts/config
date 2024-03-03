{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/nvme0n1"; # or "nodev" for efi only

  networking.hostName = "korvin-nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.korvin = {
    isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [];
   };

  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  }; 

  # List packages installed in system profile. To search, run:
   nixpkgs.config.allowUnfree = true;
   environment.systemPackages = with pkgs; [
     linux-firmware
     microcodeAmd
     neovim
     hyprland
     wlr-randr
     wofi
     waybar
     hyprpaper
     discord
     kitty
     firefox
     git
     neofetch
     fish
     pipewire
     qjackctl
     pavucontrol
     nwg-look
     rustup
     libgcc
     steam
     catppuccin-gtk
   ];

   fonts.packages = with pkgs; [
     jetbrains-mono
     nerdfonts
   ];

  system.stateVersion = "23.11"; # Did you read the comment?

}

