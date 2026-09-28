# homebrew-rookbar

Homebrew cask for [rookbar](https://github.com/SubiqT/rookbar), a native status bar for yabai.

```bash
brew install --cask subiqt/rookbar/rookbar
```

Installing enables the `com.rookbar` launch agent, so the bar starts straight away, at every login,
and again after a crash. `brew uninstall --cask rookbar` stops it and removes the agent; add `--zap`
to also remove its logs and preferences.
