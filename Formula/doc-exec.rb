# Generated with JReleaser 1.21.0 at 2025-11-05T11:16:44.900511623Z

class DocExec < Formula
  desc "ComboStrap Doc Exec"
  homepage "https://github.com/ComboStrap/doc-exec"
  version "1.0.0"
  license "Functional Source License, Version 1.1, MIT Future License"

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/combostrap-doc-exec-1.0.0-jre-linux-arm64.zip"
    sha256 "17d7fb3dd65d269202a6b2cccae8b45a75f308a3d6950bd13a7918a14de05565"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/combostrap-doc-exec-1.0.0-jre-linux-x64.zip"
    sha256 "2173f8066997ad1aff73c7ccb52aed09c322fa3056ca4672a7096915461af378"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/combostrap-doc-exec-1.0.0-jre-macos-arm64.zip"
    sha256 "47f6ad6423778eaa96547cdab8f129d562bf82cb753c4dddaeeaf575acc8c458"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/combostrap-doc-exec-1.0.0-jre-macos-x64.zip"
    sha256 "d90bbcc1f593a6d8d328ecbb221c75a0d1ce82babc5549865844720cd4714023"
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
