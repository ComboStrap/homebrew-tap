# Generated with JReleaser 1.17.0 at 2025-10-22T18:06:56.371158914Z

class DocExec < Formula
  desc "ComboStrap Doc Exec"
  homepage "https://github.com/ComboStrap/doc-exec"
  version "1.0.0"
  license "Functional Source License, Version 1.1, MIT Future License"

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/doc-exec-1.0.0-linux-x86_64.zip"
    sha256 "3fcdd1e6cc28aff83210598ce61fd7a6d92922d0f3f8d8c40fb5a77564cfaddf"
  end
  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/doc-exec-1.0.0-osx-x86_64.zip"
    sha256 "fb97abe3589cc19227e380107807804432e495f0f84cb24562b2266b28973895"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/combostrap/doc-exec/releases/download/v1.0.0/doc-exec-1.0.0-osx-x86_64.zip"
    sha256 "fb97abe3589cc19227e380107807804432e495f0f84cb24562b2266b28973895"
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
