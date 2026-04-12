# homebrew-tap

Homebrew tap for fanbuz's CLI tools.

## Available Formulae

- `gitea-cli`

## Usage

```bash
brew tap fanbuz/tap
brew install fanbuz/tap/gitea-cli
```

On supported platforms, Homebrew installs a prebuilt binary from GitHub Releases.
When no matching prebuilt archive is available yet, the formula falls back to a source build.

## Upgrade

```bash
brew update
brew upgrade gitea-cli
```

## Development

Formula files live under `Formula/`.

Current structure:

```text
Formula/
  gitea-cli.rb
```
