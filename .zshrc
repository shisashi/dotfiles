PATH=~/bin:~/programs/bin:~/programs/git-tasukete:$GRADLE_HOME/bin:$JAVA_HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/mysql/bin

if [ $ENVNAME = "MacOS" ]
then
    PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
    alias ls='gls'
elif [ $ENVNAME = "Linux" ]
then
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
alias tmux='tmux -2'

alias -g L='| lv'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g W='| wc'

alias less='less -R'

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

# completion
fpath=(/usr/local/share/zsh-completions $fpath)
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

if [ -f $HOME/perl5/perlbrew/etc/bashrc ]
then
    source $HOME/perl5/perlbrew/etc/bashrc
fi

if [ -f $HOME/.pythonz/etc/bashrc ]
then
    source $HOME/.pythonz/etc/bashrc
fi

if [ $ENVNAME = "MacOS" ]
then
    # aliases for MacVim
    PATH=/Applications/MacVim.app/Contents/MacOS:$PATH
    alias vi='env LANG=ja_JP.UTF-8 Vim "$@"'
    alias vim='env LANG=ja_JP.UTF-8 Vim "$@"'
    alias gvim='env LANG=ja_JP.UTF-8 MacVim "$@"'
    alias diff='colordiff'
elif [ $ENVNAME = "Linux" ]
then
    source ~/bin/z.sh
fi

function precmd () {
    #z --add "$(pwd -P)"
}

export EDITOR=vim

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/shisashi/.gvm/bin/gvm-init.sh" ]] && source "/Users/shisashi/.gvm/bin/gvm-init.sh"
