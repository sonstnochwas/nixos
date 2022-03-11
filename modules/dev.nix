{ pkgs, ... }: {

  #############################################################################
  # Dev configuration
  #############################################################################

  #############################################################################
  # Packages and environment
  #############################################################################

  environment.systemPackages = with pkgs; [
    stack # the haskel tool stack
    dhall # a configuration language
    cue   # data constraint language
    azure-cli
    buildah
    helm
    kubectl
  ];

  #############################################################################
  # Services
  #############################################################################

  services.k3s.enable = true;
  systemd.services.k3s.enable = false;

}