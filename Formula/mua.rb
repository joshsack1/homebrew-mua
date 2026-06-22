class Mua < Formula
  desc "Minimal coding agent with a C core embedding LuaJIT and a neovim-style API"
  homepage "https://github.com/joshsack1/mua"
  url "https://github.com/joshsack1/mua/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "0588cebacb4787f2e9a387ec26e1c0ed8ccae5ce8712bb8459db23d54d73b3d1"
  license "Apache-2.0"
  head "https://github.com/joshsack1/mua.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  # keg-only on macOS; Homebrew adds its pkg-config to PKG_CONFIG_PATH so the
  # build's `libcurl >= 7.87` requirement resolves against the recent keg.
  depends_on "curl"
  depends_on "libuv"
  depends_on "luajit"

  def install
    # Bake the runtime Lua tree's install location into the binary, and drop the
    # -dev version suffix. std_cmake_args supplies CMAKE_BUILD_TYPE=Release etc.
    system "cmake", "-S", ".", "-B", "build", "-G", "Ninja",
                    "-DMUA_VERSION_PRERELEASE=",
                    "-DMUA_RUNTIME_PATH=#{pkgshare}/runtime",
                    *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/bin/mua"
    # -> #{pkgshare}/runtime/lua/mua/init.lua, matching the baked MUA_RUNTIME_PATH.
    pkgshare.install "runtime"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/mua --version")
    # Runtime smoke: --embed boots the Lua state (require 'mua') before serving and
    # exits cleanly on stdin EOF. A mislocated runtime would abort here instead;
    # shell_output asserts the exit status is 0.
    shell_output("#{bin}/mua --embed < /dev/null")
  end
end
