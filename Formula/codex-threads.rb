class CodexThreads < Formula
  desc "Index, search, and read local Codex session history"
  homepage "https://github.com/fanbuz/codex-threads"
  version "0.1.1"
  license "MIT"
  head "https://github.com/fanbuz/codex-threads.git", branch: "main"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fanbuz/codex-threads/releases/download/v#{version}/codex-threads-macos-arm64.tar.gz"
    sha256 "20e983593486a75fb1001090939dadaeea61f42ea415a804922fca093913c45e"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/fanbuz/codex-threads/releases/download/v#{version}/codex-threads-macos-x64.tar.gz"
    sha256 "8a64b3a1e3f4a8c10021abf4b838e984ec9fcc4d14525eef623d13bc3d20cfd4"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fanbuz/codex-threads/releases/download/v#{version}/codex-threads-linux-x64.tar.gz"
    sha256 "723ce0b06c5e904b1d80895db9db655fbf44314bc945b4c2547b40ed7b61575e"
  else
    url "https://github.com/fanbuz/codex-threads/archive/refs/tags/v#{version}.tar.gz"
    sha256 "c4f51bf3bbceacf6724dfd093e606668bfb393a7063c6cd366c7583566bf48bc"

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
