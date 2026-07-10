class GiteaCli < Formula
  desc "CLI wrapper around a configured Gitea MCP server"
  homepage "https://github.com/fanbuz/gitea-cli"
  version "0.0.12"
  license "MIT"
  head "https://github.com/fanbuz/gitea-cli.git", branch: "main"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fanbuz/gitea-cli/releases/download/v#{version}/gitea-cli-macos-arm64.tar.gz"
    sha256 "5c98b72f1224ef1dcbdd735e956fec03bbbab6681ffd3b88078c987f13bd0408"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/fanbuz/gitea-cli/releases/download/v#{version}/gitea-cli-macos-amd64.tar.gz"
    sha256 "20e3a9a27c5e4e39b354b4bba36d89df7b82c5a3b42309b37f86d719376ff212"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fanbuz/gitea-cli/releases/download/v#{version}/gitea-cli-linux-x64.tar.gz"
    sha256 "f47b5d2735583e1f363e244633ba400d9aff3b55e54aa1abc2e3778631ffb903"
  else
    url "https://github.com/fanbuz/gitea-cli/archive/refs/tags/v#{version}.tar.gz"
    sha256 "14294e9518d64ad9557a77aa5e85489db6a8111b63822a0883a9da0b55aca4fb"

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
