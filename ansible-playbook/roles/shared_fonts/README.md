# Ansible Role: macOS Shared Fonts

Installs fonts from Homebrew and you can also share those fonts with other users on the same Mac by two ways:

1. Manually install the fonts in the `/Users/Shared/Fonts` folder
2. Run the same role with the other users

## Requirements:

* Homebrew: Requires `brew` already installed (you can use `geerlingguy.mac.homebrew` to install it on your Mac).

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

### `homebrew_user`

The user that you'd like to install the fonts with Homebrew with.

Default: the current user.

### `homebrew_group`

The group that you'd like to install the fonts with Homebrew with.

Default: the current user's group.

### `fonts`

The list of fonts you'd like to install via Homebrew.

Default: None

### `state`

The state of the fonts and also the fonts tap repository.

If you set it to `absent`, this role will uninstall the fonts casks and also untap the fonts tap repository.

Caveat: It does nothing to the installed fonts in your ~/Library/Fonts folder though.

Default: `present`

### `user_fonts_directory`

The directory you'd like your font(s) to be for each user.

Defaults: `~/Library/Fonts` (which is the default place for macOS to look for your fonts)

### `homebrew_fonts_directory`

The directory you'd like your font(s) to be installed into with Homebrew.
This is where the fonts are globally for all users.

Default: `/Users/Shared/Fonts`

