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

The tap checks the latest stable GitHub release for every entry in `FormulaSpec/` once an hour.
It renders any changed formulae and pushes them itself, so source repositories do not need a
long-lived cross-repository token. `gitea-cli` and `codex-threads` both use this flow.

For an immediate update, you can manually run the `Sync Formula` workflow in GitHub Actions.
It also continues to accept the legacy `sync-homebrew-formula` repository-dispatch event.

## Adding a New Project

New projects can reuse the same release-to-tap flow.

1. Add a new `FormulaSpec/<formula_name>.json` file that declares the formula class, source repository,
   binary name, and release asset names for each supported platform.
2. Commit the new spec and, if needed, bootstrap the first `Formula/<formula_name>.rb` by running the
   `Sync Formula` workflow manually with `source_repository`, `tag`, and `formula_name`.
3. Publish a GitHub Release in the source repository with the assets named by the spec.

After that one-time setup, the scheduled tap workflow discovers each new upstream release, renders the
formula with its new `version` and `sha256` values, then commits and pushes the update automatically.

The `version` field in `Formula/*.rb` is checked into git because Homebrew formulae are static files,
but it is generated from the upstream release tag by `scripts/render_formula.py` rather than maintained
by hand for each release.

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
