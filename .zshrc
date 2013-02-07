PATH=~/bin:~/programs/bin:~/programs/git-tasukete::$JAVA_HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

if [ $ENVNAME = "MacOS" ]
then
    PATH=$PATH:$(brew --prefix coreutils)/libexec/gnubin
    alias ls='gls'
else
fi

#aliases
alias back='cd $OLDPWD'
alias cp='nocorrect cp -i'
alias mv='nocorrect mv -i'
alias rm='nocorrect rm -i'
alias h='history'
alias ls='ls --color=auto -F --show-control-char'
alias l='ls'
alias sl='ls'
alias lsa='ls -FA'
alias la='ls -FA'
alias ll='ls -Fl'
alias lsl='ls -Fl'
alias lla='ls -FAl'
alias lal='ls -FAl'
alias gn='gnuclient -nw'

alias -g L='| lv'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g W='| wc'

# setopt
setopt auto_menu auto_cd auto_name_dirs auto_param_keys auto_remove_slash
setopt cdable_vars correct_all extended_history extended_glob
setopt hist_ignore_all_dups hist_ignore_space ignoreeof
setopt list_packed multios no_beep no_clobber numeric_glob_sort
setopt print_eight_bit prompt_subst pushd_ignore_dups rm_star_wait sh_word_split
setopt transient_rprompt

# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history
setopt share_history

# �⊮
#zmodload zsh/complist
autoload -U compinit
compinit -u

# zmv
autoload -U zmv

# bindkeys
bindkey -e               # emacs key bindings
bindkey ' ' magic-space  # also do history expansino on space

# color ls
eval `dircolors -b ~/.dircolors`
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

defprompt2() {
    local BLACK=$'%{\e[30m%}'
    local RED=$'%{\e[31m%}'
    local GREEN=$'%{\e[32m%}'
    local YELLOW=$'%{\e[33m%}'
    local BLUE=$'%{\e[34m%}'
    local PURPLE=$'%{\e[35m%}'
    local BLUE=$'%{\e[36m%}'
    local WHITE=$'%{\e[37m%}'

    PCOLOR_RESET=$'%{\e[0m%}'
    PCOLOR_SUCCESS=$YELLOW
    PCOLOR_ERROR=$RED

    PROMPT=$PCOLOR_SUCCESS'%n@%m[%h]_%# '$PCOLOR_RESET
    RPROMPT=$PCOLOR_SUCCESS'( %~ )'$PCOLOR_RESET
    precmd () {
        PROMPT="%{%(?.$PCOLOR_SUCCESS.$PCOLOR_ERROR)%}%n@%m[%h]_%#$PCOLOR_RESET "
        RPROMPT="%{%(?.$PCOLOR_SUCCESS.$PCOLOR_ERROR)%}( %~ )$PCOLOR_RESET "
    }
}
defprompt2

defprompt() {
    local BLACK=$'%{\e[30m%}'
    local RED=$'%{\e[31m%}'
    local GREEN=$'%{\e[32m%}'
    local YELLOW=$'%{\e[33m%}'
    local BLUE=$'%{\e[34m%}'
    local PURPLE=$'%{\e[35m%}'
    local BLUE=$'%{\e[36m%}'
    local WHITE=$'%{\e[37m%}'

    local N=$'%{\e[0m%}'
    local C=$YELLOW

    PROMPT=$C'%n@%m[%h]_%# '$N
    RPROMPT=$C'( %~ )'$N
    precmd () {
        PROMPT="%{%(?.$C.$RED)%}%n@%m[%h]_%#$N "
    }
}
#defprompt

if [ -f $HOME/.pythonbrew/etc/bashrc ]
then
    source $HOME/.pythonbrew/etc/bashrc
fi

if [ $ENVNAME = "MacOS" ]
then
    # z
    # https://github.com/rupa/z
    source `brew --prefix`/etc/profile.d/z.sh

    # aliases for MacVim
    PATH=/Applications/MacVim.app/Contents/MacOS:$PATH
    alias vi='env LANG=ja_JP.UTF-8 Vim "$@"'
    alias vim='env LANG=ja_JP.UTF-8 Vim "$@"'
    alias gvim='env LANG=ja_JP.UTF-8 MacVim "$@"'
fi

function precmd () {
    z --add "$(pwd -P)"
}

export EDITOR=vim
