# homebrew-mua

A [Homebrew](https://brew.sh) tap for [mua](https://github.com/joshsack1/mua) — a
minimal coding agent: a C core embedding LuaJIT, with a neovim-style API.

## Install

```sh
brew tap joshsack1/mua
brew install mua
```

Run `mua` for an interactive REPL, or `mua -p "your prompt"` for one-shot. mua
streams from OpenRouter and expects `OPENROUTER_API_KEY` in the environment.

## Upgrade

```sh
brew update && brew upgrade mua
```

## What gets installed

- `mua` on your `PATH`
- the shipped Lua runtime under `$(brew --prefix)/share/mua/runtime`

mua is built from source against Homebrew's `luajit`, `libuv`, and `curl`.

## License

The formula is published under the same terms as mua itself
([Apache-2.0](https://github.com/joshsack1/mua/blob/main/LICENSE)).
