class GiteaCli < Formula
  desc "CLI wrapper around a configured Gitea MCP server"
  homepage "https://github.com/fanbuz/gitea-cli"
  version "0.0.8"
  license "MIT"
  head "https://github.com/fanbuz/gitea-cli.git", branch: "main"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fanbuz/gitea-cli/releases/download/v#{version}/gitea-cli-macos-arm64.tar.gz"
    sha256 "30250c2a5581976650fe273b319a228af8581fd5a10dce263653899d233aaa2c"
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/fanbuz/gitea-cli/releases/download/v#{version}/gitea-cli-macos-amd64.tar.gz"
    sha256 "0e578094b81c3e2cdedda4dbbeb0f08d50b6378208d15df2af51dddddcf9cbe5"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fanbuz/gitea-cli/releases/download/v#{version}/gitea-cli-linux-x64.tar.gz"
    sha256 "0a78fd24ac927ec91ec3d194b36ea91b7fa6a1d40d78fec052d116cd86aef15e"
  else
    url "https://github.com/fanbuz/gitea-cli/archive/refs/tags/v#{version}.tar.gz"
    sha256 "2c4e0ffc033901e0ce8971d76707eae97d63a94303aeccdbb050abc3a7e7ac9a"

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
