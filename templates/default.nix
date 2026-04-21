{ self, ... }:

{
  empty.path = ./empty;
  docs.path = ./docs;
  tex.path = ./tex;
  python.path = ./python;
  typescript.path = ./typescript;
  go.path = ./go;
  rust.path = ./rust;

  defaultTemplate = self.empty;
}
