# homebrew-tap

Homebrew tap for [Caprine](https://github.com/bankjaneo/caprine), an unofficial fork of Caprine with continued Messenger support.

## Install

```sh
brew tap bankjaneo/tap
brew trust --cask bankjaneo/tap/caprine # only needed on Homebrew 7+ (tap trust)
brew install --cask bankjaneo/tap/caprine
```

> The fully qualified cask name (`bankjaneo/tap/caprine`) is required: the plain `caprine` name resolves to homebrew-core's disabled upstream cask.

## Notes

- The app is **not code-signed or notarized** (no Apple Developer certificate yet), so you may see a Gatekeeper prompt if you launch the DMG manually — installing via brew avoids the quarantine prompt entirely.
- Updates are managed by brew: run `brew upgrade --cask bankjaneo/tap/caprine` after a new release. The cask updates itself automatically within a day of each release (see `.github/workflows/autoupdate.yml`).
- The in-app updater is not used; the cask declares `auto_updates false`.
