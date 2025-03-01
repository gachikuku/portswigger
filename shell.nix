{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.python312Full
	pkgs.python312Packages.pip
	pkgs.python312Packages.ipython
	pkgs.python312Packages.requests
	pkgs.git
  ];

  shellHook = ''
    alias vim=nvim
  '';
}

