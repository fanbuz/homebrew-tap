class GiteaCli < Formula
  desc "CLI wrapper around a configured Gitea MCP server"
  homepage "https://github.com/fanbuz/gitea-cli"
  version "0.0.10"
  license "MIT"
  head "https://github.com/fanbuz/gitea-cli.git", branch: "main"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fanbuz/gitea-cli/releases/download/v#{version}/gitea-cli-macos-arm64.tar.gz"
    sha256 "002a1a7ccbfc8dc05217da7a8fb651606369da59ed30a9aa63e110cace914cd8"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/fanbuz/gitea-cli/releases/download/v#{version}/gitea-cli-macos-amd64.tar.gz"
    sha256 "9e3af20300085682a268bd152cc802f44fa8384a97751a21b22f25eb74a7128a"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fanbuz/gitea-cli/releases/download/v#{version}/gitea-cli-linux-x64.tar.gz"
    sha256 "5e2e790fa62e6efd0b389c748ed2fc00cb87d173828884e564753ddb72cd0551"
  else
    url "https://github.com/fanbuz/gitea-cli/archive/refs/tags/v#{version}.tar.gz"
    sha256 "b78b349621bbce6c306feb032092ba6bb7a0e1354b12625d1a3004e21ddd1eb1"

    depends_on "rust" => :build
  end

  def install
    if buildpath.join("Cargo.toml").exist?
      system "cargo", "install", *std_cargo_args(path: ".")
    else
      bin.install "gitea-cli"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gitea-cli --version")
  end
end
