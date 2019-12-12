## Installation

Run this:

```sh
$ git clone --recursive https://github.com/msanders/dotfiles ~/.dotfiles
$ sudo --validate # Request sudo privileges upfront for before & after scripts.
$ ~/.dotfiles/zero/setup
```

This will run the appropriate installers and symlink the contained files to your
home directory. Everything is configured and tweaked within `~/.dotfiles`.

For a full list of steps done on new machines, see [CHECKLIST.md](./CHECKLIST.md).

This repo uses [zero.sh](https://github.com/zero-sh/zero.sh) for system setup
and configuration.
