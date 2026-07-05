class Kubee < Formula
  desc "Kubernetes, the Easy way. Single VPS hosting and beyond."
  homepage "https://kubee.combostrap.com"
  url "https://github.com/combostrap/kubee/releases/download/v0.1.2/kubee-0.1.2.zip"
  version "0.1.2"
  sha256 "79f33460c519d5579852c50cc565efdbbf7404fa52bd0cefb68e4ecc3f384e9b"
  license "Apache-2.0"
  # https://rubydoc.brew.sh/Formula#head-class_method
  head "https://github.com/combostrap/kubee.git", branch: "main"


  depends_on "ansible@14"
  depends_on "helm@3"

  def install

    # Install all bash scripts to the bin directory
    # https://docs.brew.sh/Formula-Cookbook#bininstall-foo
    # Bin.install install the script into `/home/linuxbrew/.linuxbrew/bin/`
    bin.install Dir["bin/*"]

    # Install man pages:
    # man1.install Dir["man1/*.1"]

    # Library installation
    libexec.install "lib"
    # Not `lib.install "lib"`
    # because it will install it as shared library
    # and we get the following link problem
    # libxxx is a symlink belonging to xxx. You can unlink it

    # Installing the charts
    libexec.install "charts"

    # Installing the examples (clusters for documentation)
    libexec.install "examples"

    # Injecting the path and version in the header
    Dir["#{bin}/*"].each do |f|
      next unless File.file?(f)

      content = File.read(f).lines
      new_header = <<~EOS
        #!/usr/bin/env bash
        BASHLIB_PATH="#{libexec}/lib"
        export KUBEE_CHARTS_PATH
        if [ ${KUBEE_CHARTS_PATH:-} == "" ]; then
            KUBEE_CHARTS_PATH="#{libexec}/charts"
        else
            # Actual chart path first
            KUBEE_CHARTS_PATH="$KUBEE_CHARTS_PATH:#{libexec}/charts"
        fi
        export KUBEE_RESOURCES_DIR="#{libexec}"
        PROJECT_VERSION="0.1.2"
      EOS

      File.write(f, new_header + content.drop(1).join)
    end

end

  # https://rubydoc.brew.sh/Formula#caveats-instance_method
  def caveats
    scripts_list = bin.children.map { |script| "  - #{script.basename}" }.join("\n")
    <<~EOS
      The following scripts have been installed:

      #{scripts_list}

    EOS
  end

  test do

    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail, and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test dockenv`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.

    output = shell_output("#{bin}/kubee --help")
    # assert_match "0.1.2", output

  end
end
