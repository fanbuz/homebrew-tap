class CodexThreads < Formula
  desc "Index, search, and read local Codex session history"
  homepage "https://github.com/fanbuz/codex-threads"
  version "0.0.4"
  license "MIT"
  head "https://github.com/fanbuz/codex-threads.git", branch: "main"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fanbuz/codex-threads/releases/download/v#{version}/codex-threads-macos-arm64.tar.gz"
    sha256 "c54eebd2e6e277f28f2887664761e5aec61b2dc54b3f594c98968aabe42aaa97"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/fanbuz/codex-threads/releases/download/v#{version}/codex-threads-macos-x64.tar.gz"
    sha256 "afcf8b059ed84c13d2d32a2a59c272991a3d7b2dd0e7b0015515b25238e57a87"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fanbuz/codex-threads/releases/download/v#{version}/codex-threads-linux-x64.tar.gz"
    sha256 "81cf6a5ac128c2af32e2456336c87201576c314e6f87a593df0bdf3a9da5f18f"
  else
    url "https://github.com/fanbuz/codex-threads/archive/refs/tags/v#{version}.tar.gz"
    sha256 "4a52421725dba16b33f038b27c1dbcce7d79b00bf34edd093d28db430e01e8df"

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
