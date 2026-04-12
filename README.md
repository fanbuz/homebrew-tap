# homebrew-tap

Homebrew tap for fanbuz's CLI tools.

## Available Formulae

- `gitea-cli`
- `codex-threads`

## Usage

```bash
brew tap fanbuz/tap
brew install fanbuz/tap/gitea-cli
brew install fanbuz/tap/codex-threads
```

On supported platforms, Homebrew installs a prebuilt binary from GitHub Releases.
When no matching prebuilt archive is available yet, the formula falls back to a source build.

Current prebuilt coverage:

- `gitea-cli`: see the project release assets for supported targets
- `codex-threads`: macOS arm64, Linux x64

## Upgrade

```bash
brew update
brew upgrade gitea-cli
brew upgrade codex-threads
```

## Development

Formula files live under `Formula/`.

Current structure:

```text
Formula/
  codex-threads.rb
  gitea-cli.rb
```
