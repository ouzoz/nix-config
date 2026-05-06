{ ... }:

{
  # empty.path = ./empty;
  # docs.path = ./docs;
  # ted.path = ./ted;
  # python.path = ./python;
  # typescript.path = ./typescript;
  # rust.path = ./rust;
empty = {
    path = ./empty;
    description = "A minimal empty flake template";
  };
  docs = {
    path = ./docs;
    description = "Documentation project template";
  };
  ted = {
    path = ./ted;
    description = "Ted project template";
  };
  python = {
    path = ./python;
    description = "Python development environment";
  };
  typescript = {
    path = ./typescript;
    description = "TypeScript/Node project template";
  };
  rust = {
    path = ./rust;
    description = "Rust Cargo project template";
  };
}
