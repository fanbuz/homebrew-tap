import json
import subprocess
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "render_formula.py"


class RenderFormulaTest(unittest.TestCase):
    def test_renders_gitea_cli_formula_from_release_metadata(self) -> None:
        release = {
            "tagName": "v0.0.6",
            "assets": [
                {
                    "name": "gitea-cli-macos-arm64.tar.gz",
                    "digest": "sha256:arm64digest",
                },
                {
                    "name": "gitea-cli-macos-amd64.tar.gz",
                    "digest": "sha256:amd64digest",
                },
                {
                    "name": "gitea-cli-linux-x64.tar.gz",
                    "digest": "sha256:linuxdigest",
                },
            ],
        }

        with tempfile.TemporaryDirectory() as tmp_dir:
            tmp_path = Path(tmp_dir)
            release_json = tmp_path / "release.json"
            output_path = tmp_path / "gitea-cli.rb"
            release_json.write_text(json.dumps(release), encoding="utf-8")

            subprocess.run(
                [
                    "python3",
                    str(SCRIPT),
                    "--config",
                    str(ROOT / "FormulaSpec" / "gitea-cli.json"),
                    "--release-json",
                    str(release_json),
                    "--source-sha256",
                    "sourcesha256",
                    "--output",
                    str(output_path),
                ],
                check=True,
                cwd=ROOT,
            )

            rendered = output_path.read_text(encoding="utf-8")

        self.assertIn('class GiteaCli < Formula', rendered)
        self.assertIn('version "0.0.6"', rendered)
        self.assertIn("gitea-cli-macos-arm64.tar.gz", rendered)
        self.assertIn('sha256 "arm64digest"', rendered)
        self.assertIn("gitea-cli-macos-amd64.tar.gz", rendered)
        self.assertIn('sha256 "amd64digest"', rendered)
        self.assertIn("gitea-cli-linux-x64.tar.gz", rendered)
        self.assertIn('sha256 "linuxdigest"', rendered)
        self.assertIn('sha256 "sourcesha256"', rendered)
        self.assertIn('shell_output("#{bin}/gitea-cli --version")', rendered)

    def test_renders_codex_threads_formula_from_release_metadata(self) -> None:
        release = {
            "tagName": "v0.0.4",
            "assets": [
                {
                    "name": "codex-threads-macos-arm64.tar.gz",
                    "digest": "sha256:arm64digest",
                },
                {
                    "name": "codex-threads-macos-x64.tar.gz",
                    "digest": "sha256:x64digest",
                },
                {
                    "name": "codex-threads-linux-x64.tar.gz",
                    "digest": "sha256:linuxdigest",
                },
            ],
        }

        with tempfile.TemporaryDirectory() as tmp_dir:
            tmp_path = Path(tmp_dir)
            release_json = tmp_path / "release.json"
            output_path = tmp_path / "codex-threads.rb"
            release_json.write_text(json.dumps(release), encoding="utf-8")

            subprocess.run(
                [
                    "python3",
                    str(SCRIPT),
                    "--config",
                    str(ROOT / "FormulaSpec" / "codex-threads.json"),
                    "--release-json",
                    str(release_json),
                    "--source-sha256",
                    "sourcesha256",
                    "--output",
                    str(output_path),
                ],
                check=True,
                cwd=ROOT,
            )

            rendered = output_path.read_text(encoding="utf-8")

        self.assertIn('class CodexThreads < Formula', rendered)
        self.assertIn('version "0.0.4"', rendered)
        self.assertIn("codex-threads-macos-arm64.tar.gz", rendered)
        self.assertIn('sha256 "arm64digest"', rendered)
        self.assertIn("codex-threads-macos-x64.tar.gz", rendered)
        self.assertIn('sha256 "x64digest"', rendered)
        self.assertIn("codex-threads-linux-x64.tar.gz", rendered)
        self.assertIn('sha256 "linuxdigest"', rendered)
        self.assertIn('sha256 "sourcesha256"', rendered)
        self.assertIn('shell_output("#{bin}/codex-threads --version")', rendered)


if __name__ == "__main__":
    unittest.main()
