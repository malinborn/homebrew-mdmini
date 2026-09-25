# Homebrew Tap for couplet

couplet (formerly md-mini) — a markdown editor you and your AI agent work in together. macOS, universal (Apple Silicon + Intel).

## Install

```bash
brew tap malinborn/mdmini
brew trust malinborn/mdmini
brew install --cask couplet
```

## Usage

```bash
couplet                    # Open empty editor
couplet README.md          # Open a file
couplet file1.md file2.md  # Multiple files
```

`mdmini` (the former name) and `coup` work too — both run `couplet`.

## Update

```bash
brew update && brew upgrade --cask couplet
```

Coming from md-mini ≤1.3? `brew upgrade --cask mdmini` still works: `cask_renames.json` moves you onto the `couplet` cask, and couplet carries your data over on first launch.

## Uninstall

```bash
brew uninstall --cask couplet
```

## About

Source code: [github.com/malinborn/couplet](https://github.com/malinborn/couplet) · Website: [couplet.pro](https://couplet.pro)

Unsigned — quarantine is removed automatically on install.
