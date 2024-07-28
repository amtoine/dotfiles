{ config, pkgs, ... }:

{
  home.username = "amtoine";
  home.homeDirectory = "/home/amtoine";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" "Mononoki" "FiraCode" ]; })

    pkgs.neovim
  ];

  home.file = { };

  home.sessionVariables = { };

  programs.home-manager.enable = true;
}
