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

- `gitea-cli`: macOS arm64, macOS amd64, Linux x64
- `codex-threads`: macOS arm64, macOS x64, Linux x64

## Upgrade

```bash
brew update
brew upgrade gitea-cli
brew upgrade codex-threads
```

## Development

Formula files live under `Formula/`.
Formula automation configs live under `FormulaSpec/`.
GitHub Actions workflows live under `.github/workflows/`.

The tap can update formulae automatically after a source repository publishes a release.
For `gitea-cli`, the source repository dispatches a `sync-homebrew-formula` event to this tap,
and this repository then fetches the release metadata, renders `Formula/gitea-cli.rb`, and pushes the update itself.
`codex-threads` follows the same pattern through the shared `sync-formula.yml` workflow and `FormulaSpec/codex-threads.json`.

You can also rerun a formula sync manually from GitHub Actions via the `Sync Formula` workflow.

Current structure:

```text
Formula/
  codex-threads.rb
  gitea-cli.rb
FormulaSpec/
  codex-threads.json
  gitea-cli.json
.github/workflows/
  sync-formula.yml
scripts/
  render_formula.py
```
