# Generated with JReleaser 1.21.0 at 2025-11-04T09:34:35.585377328Z

class DocExec < Formula
  desc "ComboStrap Doc Exec"
  homepage "https://github.com/ComboStrap/doc-exec"
  version "1.0.0"
  license "Functional Source License, Version 1.1, MIT Future License"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/combostrap-doc-exec-1.0.0-jre-linux-arm64.zip"
    sha256 "61e4c847e046cf576a97f6bc9dc32a347cc6531b344c3aca96f7188d9700f0ed"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/combostrap-doc-exec-1.0.0-jre-linux-x64.zip"
    sha256 "a5ab055f2dac56130404cbe68cb2851a800a7959a8e34196516efc1297062e78"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/combostrap-doc-exec-1.0.0-jre-macos-arm64.zip"
    sha256 "352917654a24ac3a9912e9bb30e4f02a00c0b1854166447d385fd09e152ebc5d"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/combostrap-doc-exec-1.0.0-jre-macos-x64.zip"
    sha256 "d20aeec089a04b8a1881b3da9655b7ca68f7cd7d6cbbdb81cdaa6ef6a2ac6ea4"
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
