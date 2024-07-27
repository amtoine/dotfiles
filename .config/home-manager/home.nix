{ config, pkgs, ... }:

{
  home.username = "amtoine";
  home.homeDirectory = "/home/amtoine";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = [
    pkgs.hello

    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    (pkgs.writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')
  ];

  home.file = { };

  home.sessionVariables = { };

  programs.home-manager.enable = true;
}
