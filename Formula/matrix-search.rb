class MatrixSearch < Formula
  desc "Full-text search for Matrix chat: index, search, and a chat bot"
  homepage "https://github.com/yncyrydybyl/matrix-search-reloaded"
  # version is parsed from the release tarball filename
  license "AGPL-3.0-or-later"

  # Prebuilt Linux x86_64 binary. It statically links OpenSSL (portable across
  # distros) and depends only on glibc. The source lives in a private repo, so
  # the binary is hosted on this public tap for token-free installs.
  on_linux do
    on_intel do
      url "https://github.com/yncyrydybyl/homebrew-tap/releases/download/v0.3.4/matrix-search-v0.3.4-x86_64-linux.tar.gz"
      sha256 "847c5fde277a63da5305ab3b31738db902a6d382279185f4bb8ba202cf129352"
    end
  end

  def install
    bin.install "matrix-search"
    doc.install "README.md", "CHANGELOG.md"
  end

  def caveats
    <<~EOS
      matrix-search needs a config.yaml with a long-lived access token
      (Personal Access Token, mpt_ prefix). Get started:

        cp #{doc}/README.md .   # see the Config section
        matrix-search sync      # backfill + live-index your rooms
        matrix-search search "keyword"

      This bottle ships a Linux x86_64 binary only.
    EOS
  end

  test do
    assert_match "matrix-search #{version}", shell_output("#{bin}/matrix-search --version")
    # Subcommands are wired up
    assert_match "sync", shell_output("#{bin}/matrix-search --help")
  end
end
