import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


class SyncFormulaWorkflowTest(unittest.TestCase):
    def test_sync_formula_workflow_supports_repository_dispatch(self) -> None:
        workflow = (ROOT / ".github" / "workflows" / "sync-formula.yml").read_text(
            encoding="utf-8"
        )

        self.assertIn("repository_dispatch", workflow)
        self.assertIn("sync-homebrew-formula", workflow)
        self.assertIn("workflow_dispatch", workflow)
        self.assertIn("gh release view", workflow)
        self.assertIn("FormulaSpec/${FORMULA_NAME}.json", workflow)
        self.assertIn("scripts/render_formula.py", workflow)
        self.assertIn("git -C . push origin HEAD:main", workflow)
        self.assertIn("formula_name", workflow)
        self.assertIn("source_repository", workflow)
        self.assertIn("tag", workflow)


if __name__ == "__main__":
    unittest.main()
