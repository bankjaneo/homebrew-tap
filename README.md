# homebrew-tap

Homebrew tap for [Caprine](https://github.com/bankjaneo/caprine), an unofficial fork of Caprine with continued Messenger support.

## Install

```sh
brew tap bankjaneo/tap
brew install --cask caprine
```

Or in one line:

```sh
brew install --cask bankjaneo/tap/caprine
```

## Notes

- The app is **not code-signed or notarized** (no Apple Developer certificate yet), so you may see a Gatekeeper prompt if you launch the DMG manually — installing via brew avoids the quarantine prompt entirely.
- Updates are managed by brew: run `brew upgrade --cask caprine` after a new release. The cask updates itself automatically within a day of each release (see `.github/workflows/autoupdate.yml`).
- The in-app updater is not used; the cask declares `auto_updates false`.
