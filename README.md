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

## Adding a New Project

New projects can reuse the same release-to-tap flow.

1. Add a new `FormulaSpec/<formula_name>.json` file that declares the formula class, source repository,
   binary name, and release asset names for each supported platform.
2. Commit the new spec and, if needed, bootstrap the first `Formula/<formula_name>.rb` by running the
   `Sync Formula` workflow manually with `source_repository`, `tag`, and `formula_name`.
3. In the source repository, add a release workflow that triggers this tap after the GitHub Release and
   all release assets have been uploaded.

After that one-time setup, each new upstream release can follow the same automation:

1. Publish a new release in the source repository, for example `v0.0.4`.
2. Dispatch the `sync-homebrew-formula` event to this repository with the source repository name, tag,
   and formula name.
3. The tap workflow fetches the release metadata, renders the formula with the new `version` and
   `sha256` values, then commits and pushes the update automatically.

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
