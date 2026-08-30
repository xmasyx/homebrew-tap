# xmasyx/tap

Homebrew casks for the apps published at [github.com/xmasyx](https://github.com/xmasyx).
All of them are native macOS apps for Apple Silicon, signed with the project's own certificate
and not notarized by Apple.

```sh
brew install --cask xmasyx/tap/nosleep    # keeps the Mac awake until the work is done
brew install --cask xmasyx/tap/kalamos    # local dictation, nothing leaves the Mac
brew install --cask xmasyx/tap/otium      # locks the screen until you do an exercise
```

Because the apps are not notarized, macOS refuses to open a fresh download until you clear the
quarantine flag once (System Settings → Privacy & Security → *Open Anyway* does the same):

```sh
xattr -dr com.apple.quarantine /Applications/<App>.app
```

You do it once: the in-app updater clears the flag on every new copy it installs.

Already installed the app from a zip or the `install.sh` of its repo? Take it over with brew once:

```sh
brew install --cask --force xmasyx/tap/<app>
```

## Updating

Each app has a **Check for updates** button in its own panel: it runs `brew upgrade` for you and
relaunches. From the terminal it is the usual:

```sh
brew upgrade --cask xmasyx/tap/<app>
```

## How this tap stays current

`Scripts/bump.sh` reads the latest GitHub release of each app and rewrites the cask's `version`
and `sha256`. A workflow runs it every six hours (and on demand) and commits the result, after
`brew audit --cask --strict` on every file it changed. There is nothing to maintain by hand.
