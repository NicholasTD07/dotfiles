function generate_ssh_key
    echo "Generate a ssh key for you"
    echo "What's your email address?"

    read -l email
    ssh-keygen -t rsa -b 4096 -C $email

    echo ""
    echo "Done!"
end

function give_xcode_all_cpus
    defaults write com.apple.dt.Xcode IDEBuildOperationMaxNumberOfConcurrentCompileTasks (sysctl -n hw.ncpu)
end

function dont_give_xcode_all_cpus
    defaults delete com.apple.dt.Xcode IDEBuildOperationMaxNumberOfConcurrentCompileTasks
end

function how_many_cpus_xcode_use
    set CPUs (sysctl -n hw.ncpu)
    echo "You have $CPUs CPUs"
    set Xcode_has_CPUs (defaults read com.apple.dt.Xcode IDEBuildOperationMaxNumberOfConcurrentCompileTasks 2>/dev/null)
    if test $status -ne 0
        echo "Xcode is on default setting"
    else
        echo "Xcode uses $Xcode_has_CPUs CPUs"
    end
end

function mac_init
    echo "Run this after started vim once and added fishshell to /etc/shells"
    echo "Initializing your Mac :)"

    disable_xcode_indexing

    set_fish_as_default_shell

    install_fish_plugins
    install_python_packages
    install_ruby_gems
    compile_vim_plugins

    disable_bouncing_dock_icons

    echo "Your mac is set up and ready!"
end

function enable_xcode_indexing
    defaults write com.apple.dt.XCode IDEIndexDisable 0
end

function disable_xcode_indexing
    defaults write com.apple.dt.XCode IDEIndexDisable 1
end

function set_fish_as_default_shell
    echo "Setting fish as default shell"
    echo "Remember to add fish shell to /etc/shells"
    echo (which fish)
    echo ""

    chsh -s (which fish)

    echo ""
    echo "Done!"
    echo ""
end

function install_fish_plugins
    echo "Installing fish shell plugins"
    echo ""

    fisher

    echo ""
    echo "Done!"
    echo ""
end

function install_python_packages
    echo "Installing Python packages"
    echo ""

    set packages cdiff ipython virtualenv pip-tools neovim jedi

    pip2 install $packages
    pip3 install $packages

    echo ""
    echo "Done!"
    echo ""
end

function install_ruby_gems
    echo "Installing Ruby gems"
    echo ""

    gem install bundler cocoapods neovim

    echo ""
    echo "Done!"
    echo ""
end

function disable_bouncing_dock_icons
    echo "Disabling bouncing dock icons"

    defaults write com.apple.dock no-bouncing -bool TRUE
    killall Dock

    echo ""
    echo "Disabled bouncing dock icons. 😝"
    echo ""
end

function compile_vim_plugins
    compile_command_t
    compile_YCM
end

function compile_YCM
    pushd ~/.vim/.vim/bundle/YouCompleteMe/
    echo "Compiling YCM"
    ./install.py
    echo ""
    echo "Done!"
    echo ""
    popd
end

function compile_command_t
    pushd ~/.vim/.vim/bundle/command-t/ruby/command-t/
    echo "Configuring CommandT"
    ruby extconf.rb
    echo "Compiling CommandT"
    make
    echo ""
    echo "Done!"
    echo ""
    popd
end
