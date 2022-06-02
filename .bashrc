#!/bin/bash
iatest=$( echo $- | grep i; echo $? )

###############################
# Export
###############################

# Path
export PATH=/usr/local/bin:$PATH

# Editor
export VISUAL=vim
export EDITOR=vim

# Expand the history size
export HISTFILESIZE=10000
export HISTSIZE=500

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest != 1 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest != 1 ]]; then bind "set show-all-if-ambiguous On"; fi

# ls color
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

################################
# Aliases
################################
alias python='python3'

# color for grep
alias grep='grep --color=auto'

# Naviation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# fasd

alias fa='fasd -a'       # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias j='fasd_cd -d'     # cd, same functionality as j in autojump
alias jj='fasd_cd -d -i' # cd with interactive selection

# Paste terminal output to a link
alias tb="nc termbin.com 9999"

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

################################
# Prompt
################################
# Different color for SSH
#SSH_IP=$( echo $SSH_CLIENT | grep .; echo $? )
#SSH2_IP=$( echo $SSH2_CLIENT | grep .; echo $? )
#if [ "$SSH2_IP" != 1 ] || [ "$SSH_IP" != 1 ] ; then
#        PS1="\n\[\e[0;35m\]\u@\h \w\n-> \[\e[0m\]"
#else
#        PS1="\n\[\e[0;36m\]\u@\h \w\n-> \[\e[0m\]"
#fi
__powerline() {
    # Colorscheme
    RESET='\[$(tput sgr0)\]'
    COLOR_CWD='\[$(tput setaf 7)\]' # white
    COLOR_GIT='\[$(tput setaf 6)\]' # cyan
    COLOR_VIRTUAL_ENV='\[$(tput setaf 5)\]' # magenta
    COLOR_SUCCESS='\[$(tput setaf 2)\]' # green
    COLOR_FAILURE='\[$(tput setaf 1)\]' # red

    SYMBOL_GIT_MODIFIED='*'
    # unicode symbols are comprised of 3 octal code points
    # we escape all but the first code point using \[ and \]
    # to avoid errors when typing long lines in bash
    SYMBOL_GIT_BRANCH='¥' # symbol: ¥
    SYMBOL_GIT_PUSH='!' # symbol: !
    SYMBOL_GIT_PULL='¡' # symbol: ¡
    SYMBOL_VIRTUAL_ENV='@' # symbol: @
    SYMBOL_APPLE='»' # symbol: »

    ps1() {
        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly.
        if [ $? -eq 0 ]; then
            local symbol="$COLOR_SUCCESS $SYMBOL_APPLE $RESET"
        else
            local symbol="$COLOR_FAILURE $SYMBOL_APPLE $RESET"
        fi

        local cwd="$COLOR_CWD\W$RESET"

        if [ -z $VIRTUAL_ENV ]; then
            local virtualenv=""
        else
            local virtualenv=" $COLOR_VIRTUAL_ENV$SYMBOL_VIRTUAL_ENV$(basename $VIRTUAL_ENV)$RESET"
        fi

        # Fetch the git info
        local git_eng="env LANG=en_US.UTF-8 git"   # force git output in English to make our work easier

        # get current branch name
        local ref=$($git_eng symbolic-ref --short HEAD 2>/dev/null)

        if [[ -n "$ref" ]]; then
            # prepend branch symbol
            ref="$SYMBOL_GIT_BRANCH$ref"
        else
            # get tag name or short unique hash
            ref="$($git_eng describe --tags --always 2>/dev/null)"
        fi

        local git=""

        if [[ -n "$ref" ]]; then

            local marks

            # scan first two lines of output from `git status`
            while IFS= read -r line; do
                if [[ $line =~ ^## ]]; then # header line
                    [[ $line =~ ahead\ ([0-9]+) ]] && marks+=" $SYMBOL_GIT_PUSH${BASH_REMATCH[1]}"
                    [[ $line =~ behind\ ([0-9]+) ]] && marks+=" $SYMBOL_GIT_PULL${BASH_REMATCH[1]}"
                else # branch is modified if output contains more lines after the header line
                    marks="$SYMBOL_GIT_MODIFIED$marks"
                    break
                fi
            done < <($git_eng status --porcelain --branch 2>/dev/null)  # note the space between the two <

            # print the git branch segment without a trailing newline
            local git=" $COLOR_GIT$ref$marks$RESET"
        fi

        PS1="\n$cwd$virtualenv$git$symbol"
    }

    PROMPT_COMMAND="ps1${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
}

__powerline
unset __powerline

################################
# Misc
################################
# Init fasd
eval "$(fasd --init auto)"

# Vim keybindings
set -o vi

# Let user know if necessary commands don't exist
if [[ ! $( command -v fasd ) ]]; then echo "fasd needs to be installed"; fi
