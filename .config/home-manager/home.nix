{ config, pkgs, ... }:

{
  home.username = "amtoine";
  home.homeDirectory = "/home/amtoine";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [
    pkgs.hello

    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" "Mononoki" "FiraCode" ]; })

    (pkgs.writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')

    pkgs.neovim
  ];

  home.file = { };

  home.sessionVariables = { };

  programs.home-manager.enable = true;
}
