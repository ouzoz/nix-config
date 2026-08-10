# Build with current host name
[default]
build NAME="":
    sudo nixos-rebuild switch --flake .#{{ NAME }}

# Built with a specific specialization
specialization NAME:
    sudo nixos-rebuild switch --flake .# --specialisation {{ NAME }}

# Update flake inputs
update:
    nix flake update

# Remove generations older than 6 days or provided number, if parameter is 'all' delete all older generations
gc days="6":
    @if [ "{{days}}" = "all" ]; then \
        sudo nix-collect-garbage -d; \
    else \
        sudo nix-collect-garbage --delete-older-than "{{days}}d"; \
    fi

# Optimise store
optimise:
    nix-store --optimise -v

# Show flake outputs
show:
    nix flake show

# Check flake outputs
check:
    nix flake check --show-trace

# Format
fmt:
    nix fmt

# Custom env with pkg-size
pkg-size:
    nix run .#pkg-size

# Generate ssh key
key:
    ssh-keygen

# Generate hash for package
hash HASH:
    nix hash convert --to sri --hash-algo sha256 {{ HASH }}
