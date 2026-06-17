class CodexThreads < Formula
  desc "Index, search, and read local Codex session history"
  homepage "https://github.com/fanbuz/codex-threads"
  version "0.0.6"
  license "MIT"
  head "https://github.com/fanbuz/codex-threads.git", branch: "main"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fanbuz/codex-threads/releases/download/v#{version}/codex-threads-macos-arm64.tar.gz"
    sha256 "dce9b19221a3d0d0aea8d9f41dcc24b3d1c8f84856d66c55b2089ac02983eac6"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/fanbuz/codex-threads/releases/download/v#{version}/codex-threads-macos-x64.tar.gz"
    sha256 "74b23b2c87dcab1d9a500e3903ea0401e2bd4245819000e1c76b2b526825768e"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fanbuz/codex-threads/releases/download/v#{version}/codex-threads-linux-x64.tar.gz"
    sha256 "80931255116b76f559819eec7c67a5265e37702fc39c02742bb80160128f52a3"
  else
    url "https://github.com/fanbuz/codex-threads/archive/refs/tags/v#{version}.tar.gz"
    sha256 "15968734e989df95961513c2ff5e30716bb55ac3aee36e6495d3ec56c4b5d205"

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
