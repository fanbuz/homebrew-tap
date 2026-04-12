class GiteaCli < Formula
  desc "CLI wrapper around a configured Gitea MCP server"
  homepage "https://github.com/fanbuz/gitea-cli"
  version "0.0.6"
  license "MIT"
  head "https://github.com/fanbuz/gitea-cli.git", branch: "main"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fanbuz/gitea-cli/releases/download/v#{version}/gitea-cli-macos-arm64.tar.gz"
    sha256 "a543f9c0905f52c63c6e9894ba845d6216919cce371953b08559a914f8b3a64f"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/fanbuz/gitea-cli/releases/download/v#{version}/gitea-cli-macos-amd64.tar.gz"
    sha256 "04a784855d106002d622469f35abf6c885e2f6c3f2572b89c0da798ef2c5532f"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fanbuz/gitea-cli/releases/download/v#{version}/gitea-cli-linux-x64.tar.gz"
    sha256 "b5eeb9ee5f94fd979e6766d137a73943dbbfab8fd894f2359ec02e3b4ea15b09"
  else
    url "https://github.com/fanbuz/gitea-cli/archive/refs/tags/v#{version}.tar.gz"
    sha256 "a4a09d154b5bd417d1b091dccd6bd99b058dd16466c0f4c834d24cc9368e6dfc"

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
