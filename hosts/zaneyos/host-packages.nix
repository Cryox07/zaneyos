{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    audacity
    discord
    nodejs
  ];
  services = {
    flatpak = {
      packages = [

      ];
    };
  };
}
