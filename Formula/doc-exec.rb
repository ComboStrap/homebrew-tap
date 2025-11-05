# Generated with JReleaser 1.21.0 at 2025-11-05T12:09:24.085480989Z

class DocExec < Formula
  desc "ComboStrap Doc Exec"
  homepage "https://github.com/ComboStrap/doc-exec"
  version "1.0.0"
  license "Functional Source License, Version 1.1, MIT Future License"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/combostrap-doc-exec-1.0.0-jre-linux-arm64.zip"
    sha256 "3ef4cc6d928a512377892f88adefc21348a6934146338e1d89ed76239cb4b31f"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/combostrap-doc-exec-1.0.0-jre-linux-x64.zip"
    sha256 "0e00393a5cb86cfeddca9ebfeffefa259bbc4ac8db9c1b162b19ea3a8a26371a"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/combostrap-doc-exec-1.0.0-jre-macos-arm64.zip"
    sha256 "af9c34a960faadacfe4457f601d2d4a8c6a3fdbf670d1dd34e1893c64016b442"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/combostrap-doc-exec-1.0.0-jre-macos-x64.zip"
    sha256 "e63ecd8a262bb6ffce5c9424ee46ecc2d9927744ad0537cb25cf321046b33dba"
  end


  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/doc-exec" => "doc-exec"
  end

  def post_install
    if OS.mac?
      Dir["#{libexec}/lib/**/*.dylib"].each do |dylib|
        chmod 0664, dylib
        MachO::Tools.change_dylib_id(dylib, "@rpath/#{File.basename(dylib)}")
        MachO.codesign!(dylib)
        chmod 0444, dylib
      end
    end
  end

  test do
    output = shell_output("#{bin}/doc-exec --version")
    assert_match "1.0.0", output
  end
end
