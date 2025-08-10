# Homebrew Omnivore

[![Test Formula](https://github.com/Pranav-Karra-3301/homebrew-omnivore/actions/workflows/test.yml/badge.svg)](https://github.com/Pranav-Karra-3301/homebrew-omnivore/actions/workflows/test.yml)
[![Update Formula](https://github.com/Pranav-Karra-3301/homebrew-omnivore/actions/workflows/update-formula.yml/badge.svg)](https://github.com/Pranav-Karra-3301/homebrew-omnivore/actions/workflows/update-formula.yml)

This is the Homebrew tap for [Omnivore](https://github.com/Pranav-Karra-3301/omnivore), a universal Rust web crawler and knowledge graph builder.

## Installation

```bash
# Add the tap
brew tap Pranav-Karra-3301/omnivore

# Install omnivore
brew install omnivore
```

## Alternative Installation Methods

### Install from source
```bash
brew install --build-from-source omnivore
```

### Install HEAD version
```bash
brew install --HEAD omnivore
```

## What's Included

The formula installs:
- `omnivore` - Command-line web crawler
- `omnivore-api` - REST and GraphQL API server
- Configuration files in `/usr/local/etc/omnivore/`
- Shell completions for bash, zsh, and fish

## Usage

### CLI
```bash
# Basic crawl
omnivore crawl https://example.com

# Advanced crawl with custom settings
omnivore crawl https://example.com --workers 20 --depth 10

# View help
omnivore --help
```

### API Server
```bash
# Start the API server
brew services start omnivore

# Or run manually
omnivore-api

# Check server status
curl http://localhost:3000/health
```

## Configuration

The default configuration file is installed at:
- macOS: `/usr/local/etc/omnivore/crawler.toml`
- Linux: `/home/linuxbrew/.linuxbrew/etc/omnivore/crawler.toml`

Data is stored in:
- macOS: `/usr/local/var/omnivore/`
- Linux: `/home/linuxbrew/.linuxbrew/var/omnivore/`

## Updating

```bash
brew update
brew upgrade omnivore
```

## Uninstalling

```bash
brew uninstall omnivore
brew untap Pranav-Karra-3301/omnivore
```

## Building Locally

If you want to build the formula locally:

```bash
git clone https://github.com/Pranav-Karra-3301/homebrew-omnivore.git
cd homebrew-omnivore
brew install --build-from-source ./omnivore.rb
```

## Issues

For issues related to:
- **Installation**: Report here in this tap repository
- **Omnivore functionality**: Report in the [main Omnivore repository](https://github.com/Pranav-Karra-3301/omnivore/issues)

## License

This Homebrew tap is released under the MIT License.
The Omnivore software is dual-licensed under MIT OR Apache-2.0.
