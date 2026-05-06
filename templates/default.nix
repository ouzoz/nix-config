{ self, ... }:

{
  empty.path = ./empty;
  docs.path = ./docs;
  tex.path = ./tex;
  ted.path = ./ted;
  python.path = ./python;
  typescript.path = ./typescript;
  rust.path = ./rust;

  defaultTemplate = self.empty;
}
