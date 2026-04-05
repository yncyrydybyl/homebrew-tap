class Manifestor < Formula
  desc "Grab the latest file from ~/Downloads with a clean name"
  homepage "https://github.com/yncyrydybyl/manifestor"
  url "https://github.com/yncyrydybyl/manifestor/archive/refs/tags/v0.1.3.0.tar.gz"
  sha256 "9a259fdad343e1d0124ccf210aa8d018c05bb30ed432fc3d90132d6cae2d1a5e"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build",
           "-ldflags", "-s -w -X main.version=#{version}",
           "-o", bin/"m",
           "./cmd/m"
    bin.install_symlink "m" => "mm"

    generate_completions_from_executable(bin/"m", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/m --version")
    assert_match "COMP_WORDS", shell_output("#{bin}/m completion bash")
  end
end
