

test -f /opt/homebrew/bin/brew && eval "$(/opt/homebrew/bin/brew shellenv)"


# Added by Toolbox App
if test -d ~/Library/Application\ Support/JetBrains/Toolbox/scripts; then
    export PATH="$PATH:/Users/bosco.so/Library/Application Support/JetBrains/Toolbox/scripts"
fi
