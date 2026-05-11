{pkgs, ...}: {
  # Only enable either docker or podman -- Not both
  virtualisation = {
    docker = {
      enable = true;
    };

    podman.enable = false;

    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        verbatimConfig = ''
          user = "marcel"
          group = "libvirtd"
        '';
      };
    };

    virtualbox.host = {
      enable = false;
      enableExtensionPack = true;
    };
  };

  # Manage the virtualisation services
  programs.virt-manager.enable = true;

  # Add your user to the libvirtd group
  users.users.marcel.extraGroups = ["networkmanager" "wheel" "libvirtd" "kvm" "video" "render"];

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virtio-win # Essential drivers for Windows performance
    win-spice
    swtpm
    lazydocker
    docker-client
  ];
}
