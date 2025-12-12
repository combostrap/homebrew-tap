# Generated with JReleaser 1.21.0 at 2025-11-08T09:51:13.298744467Z

class DocExec < Formula
  desc "ComboStrap Doc Exec"
  homepage "https://github.com/combostrap/doc-exec"
  version "1.0.0"
  license "Functional Source License, Version 1.1, MIT Future License"
  url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/combostrap-doc-exec-1.0.0-nojre.zip"
  sha256 "00d660779b8298d9d43df80853b2d41a4491835acff60bd36fb8c53c92d03505"

  depends_on "openjdk@17"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/doc-exec" => "doc-exec"
  end

  test do
    output = shell_output("#{bin}/doc-exec --version")
    assert_match "1.0.0", output
  end
end
