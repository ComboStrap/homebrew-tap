# Generated with JReleaser 1.21.0 at 2025-11-05T11:10:23.030825981Z

class DocExec < Formula
  desc "ComboStrap Doc Exec"
  homepage "https://github.com/ComboStrap/doc-exec"
  version "1.0.0"
  license "Functional Source License, Version 1.1, MIT Future License"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/combostrap-doc-exec-1.0.0-jre-linux-arm64.zip"
    sha256 "8306f27350be4f142bec43628debac11cc4cd7c37270db138307358729c433ad"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/combostrap-doc-exec-1.0.0-jre-linux-x64.zip"
    sha256 "9ff0ca1882805d4a10f65247f3f641d70d7072c3a6744ab9cd9ad9f6ef552913"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/combostrap-doc-exec-1.0.0-jre-macos-arm64.zip"
    sha256 "266af317f8cb36be6b8719ee05484623cdf05df9d39646b5ae595c660f4bcb65"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/combostrap-doc-exec-1.0.0-jre-macos-x64.zip"
    sha256 "1460ea27a3583e14df983c5322611b9edf3d05bac966852ed3f3a1dea1914c71"
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
