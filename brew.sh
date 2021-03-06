#!/usr/bin/env bash

##
# Install command-line tools using Homebrew
##

# Make sure we’re using the latest Homebrew
brew update

brew upgrade

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew tap homebrew/dupes
brew install coreutils
brew install binutils
brew install findutils --with-default-names
brew install diffutils

brew install moreutils
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gawk
brew install gnutls
brew install grep --with-default-names
brew install screen
brew install watch
brew install wdiff --with-gettext


# Install Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
brew install bash
brew install bash-completion

brew install grc
brew install wget --with-iri

# Install more recent versions of some OS X tools
brew install vim --override-system-vi --with-luajit --with-python3

# Install other useful binaries
brew install the_silver_searcher
brew install git
brew install bzr
brew install hg
brew install imagemagick --with-webp
brew install pv
brew install rename
brew install tree
brew install zopfli
brew install ffmpeg --with-libvpx
brew install git-tracker
brew install ssh-copy-id
brew install reattach-to-user-namespace --with-wrap-pbcopy-and-pbpaste

# Install native apps
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# dev
brew cask install iterm2
brew cask install sublime-text3
brew cask install imagealpha
brew cask install imageoptim
brew install tmux
brew install cmake
brew install ctags
brew install cscope
brew install go
brew install macvim --with-luajit --with-python3
brew install --HEAD neovim/neovim/neovim
brew install jq

# java
brew cask install java
brew install jenv

# fun
brew cask install vlc
brew cask install skype
brew cask install spotify

# ssl and mongodb
brew install openssl
brew link openssl
brew install mongodb --with-openssl

# add services command for easy stop/start of daemons
brew tap homebrew/services

# Fonts
brew tap caskroom/fonts
fonts=(
	font-source-code-pro
	font-roboto
)
brew cask install "${fonts[@]}"


# Remove outdated versions from the cellar
brew cleanup
