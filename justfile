# Build with current host name
[default]
[group('main')]
build NAME="":
    sudo nixos-rebuild switch --flake .#{{ NAME }}

# Built with a specific specialization
[group('main')]
specialization NAME:
    sudo nixos-rebuild switch --flake .# --specialisation {{ NAME }}

# Update flake inputs
[group('main')]
update:
    nix flake update

# Remove all generations except current
[group('main')]
gc:
    sudo nix-collect-garbage -d

# Custom env with pkg-size
[group('main')]
pkg-size:
    nix run .#pkg-size

# Show flake outputs
[group('dev')]
show:
    nix flake show

# Check flake outputs
[group('dev')]
check:
    nix flake check --show-trace

# Format
[group('dev')]
fmt:
    nix fmt

# Generate ssh key
[group('dev')]
key:
    ssh-keygen

# Generate hash for package
[group('dev')]
hash HASH:
    nix hash convert --to sri --hash-algo sha256 {{ HASH }}
