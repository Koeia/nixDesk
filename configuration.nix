{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./services.nix
    ./hardware-configuration.nix
    ./lsps.nix
    ./devtools.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixDesk";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  time.timeZone = "America/New_York";

  services = {
    desktopManager.plasma6.enable = true;

    displayManager.plasma-login-manager.enable = true;

    xserver.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    elisa
  ];

  users.users.jctannu4 = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    fuzzel
    kitty
    git-credential-manager
    libsecret
    package-version-server
    git
    vim
    wget
    curl
    alacritty
    waybar
    zed-editor
    quickshell
    kdePackages.dolphin
    brightnessctl
    udiskie
    usbutils
    gnome-clocks
    yazi
    termius
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "26.05";

}
