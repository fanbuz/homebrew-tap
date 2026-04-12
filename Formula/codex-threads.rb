class CodexThreads < Formula
  desc "Index, search, and read local Codex session history"
  homepage "https://github.com/fanbuz/codex-threads"
  version "0.0.2"
  license "MIT"
  head "https://github.com/fanbuz/codex-threads.git", branch: "main"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fanbuz/codex-threads/releases/download/v#{version}/codex-threads-macos-arm64.tar.gz"
    sha256 "124d5b0a9145dee480ba68644677e0e5912f171a3eaf6a56130f0a9e02a18690"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fanbuz/codex-threads/releases/download/v#{version}/codex-threads-linux-x64.tar.gz"
    sha256 "32f577163c797a3f73faa67e18b964c9d397c288840ee3f552a0b3cd99840c6a"
  else
    url "https://github.com/fanbuz/codex-threads/archive/refs/tags/v#{version}.tar.gz"
    sha256 "2cd3391c417c3f01c18fa72869824aeaf5208d701a0f822eb61cddd101e67bc7"

    depends_on "rust" => :build
  end

  def install
    if buildpath.join("Cargo.toml").exist?
      system "cargo", "install", *std_cargo_args(path: ".")
    else
      bin.install "codex-threads"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/codex-threads --version")
  end
end
