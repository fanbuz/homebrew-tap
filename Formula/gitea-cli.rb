class GiteaCli < Formula
  desc "CLI wrapper around a configured Gitea MCP server"
  homepage "https://github.com/fanbuz/gitea-cli"
  version "1.9.0"
  license "MIT"
  head "https://github.com/fanbuz/gitea-cli.git", branch: "main"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fanbuz/gitea-cli/releases/download/v#{version}/gitea-cli-macos-arm64.tar.gz"
    sha256 "7e7387dce55fb1ddc54292b361c2629b9421694843d07444c0eaa5cda2cb863d"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/fanbuz/gitea-cli/releases/download/v#{version}/gitea-cli-macos-amd64.tar.gz"
    sha256 "4213da8d1789c420429d7b05afa6806e7850990c56c34a552b5e2d1238fe1243"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fanbuz/gitea-cli/releases/download/v#{version}/gitea-cli-linux-x64.tar.gz"
    sha256 "109428ccd0147c06ae9de6ca71b56c3af8f21ac3a60196817a2981c3fd433bd0"
  else
    url "https://github.com/fanbuz/gitea-cli/archive/refs/tags/v#{version}.tar.gz"
    sha256 "64b3ef0da3c467bdc0a718a24d3f92d858fa4da60d1c4f973d92a7b7d5c0e719"

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
