{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nate-nix";
  home.homeDirectory = "/home/nate-nix";

  # Packages to be installed to the user profile.
  home.packages = with pkgs; [
    htop
    xorg.xinit
    xterm
    awesome
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Graphical environment setup.
  home.file.".xinitrc".text = ''
    exec awesome
  '';

  home.file.".config/awesome/rc.lua".source = ./awesome-wm/rc.lua;
  home.file.".config/awesome/theme.lua".source = ./awesome-wm/theme.lua;

  programs.bash.enable = true;
  programs.bash.initExtra = ''
    if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty2" ]; then
      exec startx
    fi
  '';

  home.sessionVariables = {
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
  };
}
