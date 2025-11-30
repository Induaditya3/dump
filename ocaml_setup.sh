#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Install OPAM
sudo apt-get update
sudo apt-get install -y opam

# Initialize OPAM
opam init -a -y
opam update

# Create and switch to OCaml 4.14.2
opam switch create 4.14.2
opam switch 4.14.2

# Install required packages
opam install -y graphics
opam install -y ocamlbuild
opam install -y ocamlfind
opam install -y ocamlnet
opam install -y yojson
opam install -y merlin
opam install -y utop
opam install -y menhir

# Pin CS51Utils library
opam pin add CS51Utils https://github.com/cs51/utils.git -y

# Update environment variables
eval $(opam env)

echo "OCaml environment setup complete!"