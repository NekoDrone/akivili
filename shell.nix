let
  pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz";
    sha256 = "sha256:1bl9m26b0fvrfi8a8s5ygda7s7m150yiv238w7l5q6icy1i3nfmp";
  }) { };
in
pkgs.mkShell {
  packages = with pkgs; [
    gleam
    beamMinimal28Packages.erlang
    beamMinimal28Packages.rebar3
  ];
}
