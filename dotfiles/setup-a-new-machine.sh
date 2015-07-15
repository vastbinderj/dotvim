##
## new machine setup.
##

WORKDIR=`pwd`
GOSYSTEMVERSION=`go version`

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Found Mac OSX

    #
    # homebrew!
    #
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # then install things
    ./brew.sh


    # github.com/thebitguru/play-button-itunes-patch
    # disable itunes opening on media keys
    git clone https://github.com/thebitguru/play-button-itunes-patch ~/code/play-button-itunes-patch


    # change to bash 4 (installed by homebrew)
    BASHPATH=$(brew --prefix)/bin/bash
    sudo echo $BASHPATH >> /etc/shells
    chsh -s $BASHPATH # will set for current user only.
    echo $BASH_VERSION # should be 4.x not the old 3.2.X
    # Later, confirm iterm settings aren't conflicting.

    # create GOPATH dirs
    if [ ! -d "$HOME/go" ]; then
        mkdir -p $HOME/go
        mkdir -p $HOME/go/{src,pkg,bin}
    fi

    # create code dir
    if [ ! -d "$HOME/code" ]; then
        mkdir -p $HOME/code
    fi

elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    # Found Linux

    if [ -f /etc/lsb-release  ]; then
        # Found Ubuntu
        . /etc/lsb-release

        # Add PPAs
        sudo add-apt-repository ppa:neovim-ppa/unstable -y
        sudo apt-get update

        # Install stuff
        sudo apt-get install \
            bash-completion \
            build-essential \
            mercurial \
            curl \
            git \
            binutils \
            bison \
            gcc \
            libc6-dev \
            bzr \
            exuberant-ctags \
            cmake \
            grc \
            neovim \
            python-dev \
            python-setuptools \
            python3-dev \
            python3-setuptools \
            rbenv \
            ruby-build \
            vim-nox \
            silversearcher-ag \
            -y --reinstall

    elif [ -f /etc/os-release  ]; then
        # Found Debian
        . /etc/os-release

        sudo apt-get update
        # Install stuff
        sudo apt-get install \
            bash-completion \
            build-essential \
            mercurial \
            curl \
            git \
            binutils \
            bison \
            gcc \
            libc6-dev \
            bzr \
            exuberant-ctags \
            cmake \
            grc \
            python-dev \
            python-setuptools \
            python3-dev \
            python3-setuptools \
            rbenv \
            ruby-build \
            vim-nox \   
            silversearcher-ag \
            -y --reinstall
        fi

    # create GOPATH dirs
    if [ ! -d "$HOME/go" ]; then
        mkdir -p $HOME/go
        mkdir -p $HOME/go/{src,pkg,bin}
    fi

    # create code dir
    if [ ! -d "$HOME/code" ]; then
        mkdir -p $HOME/code
    fi
fi

# go.googlesource.com/go
# install golang from the source repository
if [[ "$GOSYSTEMVERSION" == *"go1.4.2"* ]]; then
    # clean up soure dir if exists already
    if [ -d  $HOME/code/go ]; then 
        rm -f $HOME/code/go
    fi
    git clone https://go.googlesource.com/go $HOME/code/go
    cd $HOME/code/go
    # checkout go 1.4.2
    git checkout go1.4.2
    cd $HOME/code/go/src
    # build from source
    CMD="sudo ./all.bash"
    eval $CMD
    # back to working dir
    cd $WORKDIR
    unset CMD
fi

# github.com/jamiew/git-friendly
# the `push` command which copies the github compare URL to my clipboard is heaven
bash < <( curl https://raw.github.com/jamiew/git-friendly/master/install.sh)


# github.com/mooveweb/gvm
# use gvm for golang versions
#bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)


# github.com/rupa/z   - oh how i love you
git clone https://github.com/rupa/z.git $HOME/code/z
chmod +x ~/code/z/z.sh
# consider reusing your current .z file if possible. it's painful to rebuild :)
# z hooked up in .bash_profile


# for the c alias (syntax highlighted cat)
sudo easy_install Pygments


# clone vundle in ~/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim


# install vundle packages in vim
vim +PluginInstall +qall

# build YouCompleteMe
if [ -f $HOME/.vim/bundle/YouCompleteMe/install.sh  ]; then
    $HOME/.vim/bundle/YouCompleteMe/install.sh --clang-completer
fi


# symlinks!
#   put/move git credentials into ~/.gitconfig.local
#   http://stackoverflow.com/a/13615531/89484
./symlink-setup.sh

