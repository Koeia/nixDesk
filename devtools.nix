{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    android-tools
    nmap
    wireshark-cli
    jetbrains.webstorm
    jetbrains.gateway
  ];
}
