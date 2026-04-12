class CodexThreads < Formula
  desc "Index, search, and read local Codex session history"
  homepage "https://github.com/fanbuz/codex-threads"
  version "0.0.3"
  license "MIT"
  head "https://github.com/fanbuz/codex-threads.git", branch: "main"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fanbuz/codex-threads/releases/download/v#{version}/codex-threads-macos-arm64.tar.gz"
    sha256 "f7f362536e742f7e3c23323d89695e5532cedbeea3b70604c9c0084aa66ad275"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/fanbuz/codex-threads/releases/download/v#{version}/codex-threads-macos-x64.tar.gz"
    sha256 "8166a120765a2b50a4da0ef847a16786338249ddbbbee7bde57ffdf3014abf43"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fanbuz/codex-threads/releases/download/v#{version}/codex-threads-linux-x64.tar.gz"
    sha256 "50b2f504abb74298ee7f9e313f25c09b5c41a105cc2362a61fe0ac0adf5a043a"
  else
    url "https://github.com/fanbuz/codex-threads/archive/refs/tags/v#{version}.tar.gz"
    sha256 "5746bd11faa438e8ba8b84a0f8834def726670ba694f0d8dba7a0963420c666b"

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
