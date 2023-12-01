# ansible-macOS-playbook

I try my best to automate as much as I can to set up my Macs for development work.

## Installation

(Mostly taken from [@geerlingguy](https://github.com/geerlingguy) 's [Mac Development Ansible Playbook](https://github.com/geerlingguy/mac-dev-playbook) as pointed out inthe Credits section)

1. Ensure Apple's command line tools are installed (`xcode-select --install` to launch the installer).
2. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html):
    1. Run the following command to add Python 3 to your $PATH: `export PATH="$HOME/Library/Python/3.9/bin:/opt/homebrew/bin:$PATH"`
        * Note: The version of Python might change when you are running the script. Check the output of `python3 --version` for your Python 3's major and minor version numbers, i.e. `3.9` in this command.
    2. Upgrade Pip: `sudo pip3 install --upgrade pip`
    3. Install Ansible: `pip3 install ansible`
3. Clone or download this repository.
4. Run `ansible-galaxy install -r requirements.yml` inside this directory to install required Ansible roles..
5. Run `ansible-playbook main.yml --ask-become-pass` inside this directory. Enter your macOS account password when prompted for the 'BECOME' password.

> Note: If some Homebrew commands fail, you might need to agree to Xcode's license or fix some other Brew issue. Run brew doctor to see if this is the case.

## Credits

This project is heavily inspired by other people's work, namely:

- [Jeff Geerling aka @geerlingguy](https://github.com/geerlingguy) 's [Mac Development Ansible Playbook](https://github.com/geerlingguy/mac-dev-playbook)
- [Patrick Quinn-Graham aka @thepatrick](https://github.com/thepatrick)'s [inventory](https://github.com/thepatrick/inventory)
