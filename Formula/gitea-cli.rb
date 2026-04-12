class GiteaCli < Formula
  desc "CLI wrapper around a configured Gitea MCP server"
  homepage "https://github.com/fanbuz/gitea-cli"
  url "https://github.com/fanbuz/gitea-cli/archive/refs/tags/v0.0.4.tar.gz"
  sha256 "3a918c534d7cfe87c584ac333f4c1c1785cf4cbe93099eac297cbe37b5296e43"
  license "MIT"
  head "https://github.com/fanbuz/gitea-cli.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gitea-cli --version")
  end
end
