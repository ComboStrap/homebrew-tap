# Generated with JReleaser 1.17.0 at 2025-10-23T11:40:31.184030968Z

class DocExec < Formula
  desc "ComboStrap Doc Exec"
  homepage "https://github.com/ComboStrap/doc-exec"
  version "1.0.0"
  license "Functional Source License, Version 1.1, MIT Future License"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/doc-exec-1.0.0-linux-x86_64.zip"
    sha256 "aa582fb9e4a509cb3eab00555abf4856630dff29b2e52d61cd4807e596dcddcc"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/doc-exec-1.0.0-osx-x86_64.zip"
    sha256 "ab8aa1975a2ca6487096ce83f95c1966f4ba0e07d64555ec81070bee60c6dae6"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/doc-exec-1.0.0-osx-x86_64.zip"
    sha256 "ab8aa1975a2ca6487096ce83f95c1966f4ba0e07d64555ec81070bee60c6dae6"
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
