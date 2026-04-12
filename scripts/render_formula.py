#!/usr/bin/env python3

import argparse
import json
from pathlib import Path


TEMPLATE = """class {formula_class} < Formula
  desc "{description}"
  homepage "{homepage}"
  version "{version}"
  license "{license}"
  head "https://github.com/{repository}.git", branch: "{head_branch}"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/{repository}/releases/download/v#{{version}}/{macos_arm64_name}"
    sha256 "{macos_arm64_sha}"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/{repository}/releases/download/v#{{version}}/{macos_amd64_name}"
    sha256 "{macos_amd64_sha}"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/{repository}/releases/download/v#{{version}}/{linux_x64_name}"
    sha256 "{linux_x64_sha}"
  else
    url "https://github.com/{repository}/archive/refs/tags/v#{{version}}.tar.gz"
    sha256 "{source_sha}"

    depends_on "rust" => :build
  end

  def install
    if buildpath.join("Cargo.toml").exist?
      system "cargo", "install", *std_cargo_args(path: ".")
    else
      bin.install "{binary_name}"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{{bin}}/{binary_name} --version")
  end
end
"""


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Render a Homebrew formula from release metadata and a formula config."
    )
    parser.add_argument("--config", required=True, help="Path to formula config JSON")
    parser.add_argument("--release-json", required=True, help="Path to gh release JSON")
    parser.add_argument(
        "--source-sha256",
        required=True,
        help="sha256 for the source tarball fallback",
    )
    parser.add_argument("--output", required=True, help="Formula output path")
    return parser.parse_args()


def load_json(path: Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))


def build_asset_map(release: dict) -> dict[str, str]:
    assets = {}
    for asset in release.get("assets", []):
        digest = asset.get("digest", "")
        if digest.startswith("sha256:"):
            assets[asset["name"]] = digest.removeprefix("sha256:")
    return assets


def require_asset(assets: dict[str, str], name: str) -> str:
    if name not in assets:
        raise SystemExit(f"missing release asset digest for {name}")
    return assets[name]


def render_formula(config: dict, release: dict, source_sha: str) -> str:
    version = release["tagName"].removeprefix("v")
    assets = build_asset_map(release)
    asset_names = config["asset_names"]

    return TEMPLATE.format(
        formula_class=config["formula_class"],
        description=config["description"],
        homepage=config["homepage"],
        repository=config["repository"],
        version=version,
        license=config.get("license", "MIT"),
        head_branch=config.get("head_branch", "main"),
        binary_name=config["binary_name"],
        macos_arm64_name=asset_names["macos_arm64"],
        macos_arm64_sha=require_asset(assets, asset_names["macos_arm64"]),
        macos_amd64_name=asset_names["macos_amd64"],
        macos_amd64_sha=require_asset(assets, asset_names["macos_amd64"]),
        linux_x64_name=asset_names["linux_x64"],
        linux_x64_sha=require_asset(assets, asset_names["linux_x64"]),
        source_sha=source_sha,
    )


def main() -> None:
    args = parse_args()
    config = load_json(Path(args.config))
    release = load_json(Path(args.release_json))
    rendered = render_formula(config, release, args.source_sha256)
    output_path = Path(args.output)
    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(rendered, encoding="utf-8")


if __name__ == "__main__":
    main()
