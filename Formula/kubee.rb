class Kubee < Formula
  desc "Kubee - Kubernetes the Easy Way. Single VPS hosting and beyond"
  homepage "https://github.com/combostrap/kubee"
  license "MIT"
  # https://rubydoc.brew.sh/Formula#head-class_method
  head "https://github.com/combostrap/kubee.git", branch: "main"
  # head "file:///home/admin/code/bash-lib", branch: "main", using: :git
  # Head replace the url, sha256 and version properties???
  # url "https://github.com/bb010g/betterdiscordctl"
  # version "2.0.1"
  # sha256 "63d1de17449611f1490b1930e63cc8890f9f10c7e317f02c901e6a79236c10e2"

  depends_on "gerardnico/tap/bashlib"
  # depends_on "cmake" => :build
  
  def install
    
    bin.install Dir["bin/*"]

    # Install man pages:
    man1.install Dir["docs/man/man1/*.1"]
    
    # [Ref](https://rubydoc.brew.sh/Formula#libexec-instance_method)
    # Install all .sh files from the libs directory to #{prefix}/libexec
    # and symlink to /usr/local/lib
    # where prefix resolves to resolves to where homebrew is installed
    # 
    # Install libraries to libexec of HOMEBREW
    # ie /home/linuxbrew/.linuxbrew/libexec
    #libexec.install Dir["lib/*.sh"]
    
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
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test dockenv`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    
    # Example
    #  system "#{bin}/script1", "--version"
    system "#{bin}/kubee", "--help"
  end
end

