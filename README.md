# Auto update Brew once per day

As a macOS user, I use Homebrew as a package manager. I like keeping it up to date and I wanted to automate the process since typing the commands
```bash
$ brew update
$ brew outdated
$ brew upgrade
$ brew cleanup
```
was tiresome. That's why I wrote this small shell script that is called each time a new shell is created in iTerm2.

## What it does

Since brew update/upgrade usually takes very long, I wanted to update it only once a day.
When called, the script compares the current date and a global env variable (defined in my `.zshrc`) representing the last update. If the day is different, it silently updates Homebrew and creates a log file in its directory.

## How to use it

Just replace the variables `ZSHRC_FILE` and `BREW_UPDATE_DIR` with your custom values, in iTerm2 Preferences > Profiles > Your profile > Command add the following command `zsh <path_to_project>/brew-update.zsh`, and you're ready to go !

## Warning:

Line 24 in the `brew-update.sh`: \
*This syntax of sed is macOS specific. On Linux, you should not need the empty ''*