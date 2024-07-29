{ config, pkgs, ... }:

{
  home.username = "amtoine";
  home.homeDirectory = "/home/amtoine";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "Mononoki" "FiraCode" ]; })

    pkgs.neovim
  ];

  home.file = { };

  home.sessionVariables = { };

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;
}
