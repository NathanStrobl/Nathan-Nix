{ config, pkgs, lib, ... }:

{
  home.username = "nate";
  home.homeDirectory = "/home/nate";
  home.stateVersion = "25.05-pre"; # Use appropriate version

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install X and Xfce packages
  home.packages = with pkgs; [
    # X.org packages
    xorg.xorgserver
    xorg.xinit
    xorg.xauth
    xorg.xinput
    xorg.xrdb
    xorg.xrandr
    xorg.xset
    
    # Xfce core components
    xfce.xfce4-panel
    xfce.xfce4-session
    xfce.xfce4-settings
    xfce.xfdesktop
    xfce.xfwm4
    xfce.exo
    xfce.garcon
    xfce.libxfce4ui
    xfce.libxfce4util
    
    # Xfce applications
    xfce.thunar
    xfce.thunar-volman
    xfce.tumbler
    xfce.xfce4-appfinder
    xfce.xfce4-notifyd
    xfce.xfce4-screenshooter
    xfce.xfce4-terminal
    xfce.xfce4-power-manager
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-whiskermenu-plugin
    
    # Display manager (optional if using system DM)
    lightdm
    lightdm-gtk-greeter
    
    # Basic desktop utilities
    nitrogen # wallpaper manager
    networkmanagerapplet
    pavucontrol # audio control
    arandr # screen layout
    
    # Common applications
    firefox
    gnome.file-roller # archive manager
    gnome.gnome-calculator
  ];

  # Configure X11
  xsession = {
    enable = true;
    windowManager.command = "startxfce4";
    
    # This creates a .xsession file that launches Xfce
    scriptPath = ".xsession";
  };

  # Configure .xinitrc as well
  home.file.".xinitrc" = {
    text = ''
      #!/bin/sh
      if [ -d $HOME/.nix-profile/etc/xdg ]; then
        export XDG_CONFIG_DIRS="$HOME/.nix-profile/etc/xdg''${XDG_CONFIG_DIRS:+:$XDG_CONFIG_DIRS}"
      fi
      
      if [ -d $HOME/.nix-profile/share ]; then
        export XDG_DATA_DIRS="$HOME/.nix-profile/share''${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}"
      fi
      
      exec startxfce4
    '';
    executable = true;
  };

  # Configure Xfce settings
  xdg.configFile = {
    # Example Xfce panel configuration
    "xfce4/panel/whiskermenu-1.rc" = {
      text = ''
        favorites=firefox.desktop,thunar.desktop,xfce4-terminal.desktop
        recent=
        button-title=Applications
        button-icon=xfce4-whiskermenu
        button-single-row=false
        show-button-title=false
        show-button-icon=true
        launcher-show-name=true
        launcher-show-description=true
        launcher-show-tooltip=true
        item-icon-size=2
        hover-switch-category=false
        category-show-name=true
        category-icon-size=1
        load-hierarchy=false
        view-as-icons=false
        default-category=0
        recent-items-max=10
        favorites-in-recent=true
        position-search-alternate=false
        position-commands-alternate=false
        position-categories-alternate=false
        menu-width=400
        menu-height=500
        menu-opacity=100
        command-settings=xfce4-settings-manager
        show-command-settings=true
        command-lockscreen=xflock4
        show-command-lockscreen=true
        command-switchuser=gdmflexiserver
        show-command-switchuser=false
        command-logout=xfce4-session-logout
        show-command-logout=true
        command-menueditor=menulibre
        show-command-menueditor=false
        command-profile=mugshot
        show-command-profile=false
        search-actions=5
        
        [action0]
        name=Man Pages
        pattern=#
        command=exo-open --launch TerminalEmulator man %s
        regex=false
        
        [action1]
        name=Web Search
        pattern=?
        command=exo-open --launch WebBrowser https://duckduckgo.com/?q=%u
        regex=false
        
        [action2]
        name=Wikipedia
        pattern=!w
        command=exo-open --launch WebBrowser https://en.wikipedia.org/wiki/%u
        regex=false
        
        [action3]
        name=Run in Terminal
        pattern=!
        command=exo-open --launch TerminalEmulator %s
        regex=false
        
        [action4]
        name=Open URI
        pattern=^(file|http|https):\\/\\/(.*)$
        command=exo-open \\0
        regex=true
      '';
    };
  };

  # Enable home-manager
  programs.home-manager.enable = true;
}
