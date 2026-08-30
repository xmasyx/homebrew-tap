# xmasyx/tap

Homebrew casks for the apps published at [github.com/xmasyx](https://github.com/xmasyx).
All of them are native macOS apps for Apple Silicon, signed with the project's own certificate
and not notarized, which is why the install line carries `--no-quarantine`.

```sh
brew install --cask --no-quarantine xmasyx/tap/nosleep    # keeps the Mac awake until the work is done
brew install --cask --no-quarantine xmasyx/tap/kalamos    # local dictation, nothing leaves the Mac
brew install --cask --no-quarantine xmasyx/tap/otium      # locks the screen until you do an exercise
```

Already installed the app from a zip or the `install.sh` of its repo? Take it over with brew once:

```sh
brew install --cask --no-quarantine --force xmasyx/tap/<app>
```

## Updating

Each app has a **Check for updates** button in its own panel: it runs `brew upgrade` for you and
relaunches. From the terminal it is the usual:

```sh
brew upgrade --cask --no-quarantine xmasyx/tap/<app>
```

## How this tap stays current

`Scripts/bump.sh` reads the latest GitHub release of each app and rewrites the cask's `version`
and `sha256`. A workflow runs it every six hours (and on demand) and commits the result, after
`brew audit --cask --strict` on every file it changed. There is nothing to maintain by hand.
