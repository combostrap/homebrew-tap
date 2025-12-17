# Generated with JReleaser 1.21.0 at 2025-12-17T11:12:07.267430398Z

class DocExec < Formula
  desc "Doc Exec, execution of code block inside documentation"
  homepage "https://github.com/ComboStrap/doc-exec"
  url "https://github.com/combostrap/doc-exec/releases/download/v1.1.0/combostrap-doc-exec-1.1.0-nojre.zip"
  version "1.1.0"
  sha256 "291dcfdd2a8769623c6ba494035075fda0715f4c72b1a70780b129a64988511e"
  license "Functional Source License, Version 1.1, MIT Future License"

  depends_on "openjdk@11"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/doc-exec" => "doc-exec"
  end

  test do
    output = shell_output("#{bin}/doc-exec --version")
    assert_match "1.1.0", output
  end
end
