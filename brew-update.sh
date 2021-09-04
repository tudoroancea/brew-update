#!/usr/local/bin/zsh

# Config variables (to change depending on your system)==================
ZSHRC_FILE="/Users/tudoroancea/.zshrc"
BREW_UPDATE_DIR="/Users/tudoroancea/Developer/divers/brew-update/"

# local variables =============================
LINE=`grep 'LAST_BREW_UPDATE' $ZSHRC_FILE`
OLD_DATE=${LINE:24}
CURRENT_DATE=`date +%d-%m`
BREW_UPDATE_LOG_FILE=$BREW_UPDATE_DIR"logs/log-"$CURRENT_DATE".txt"

# Actual update procedure ===============================
if [ $OLD_DATE != $CURRENT_DATE ]
then
    echo "Trying to update Homebrew..."
    cd $BREW_UPDATE_DIR
    brew update &> $BREW_UPDATE_LOG_FILE
    read OUTPUT < $BREW_UPDATE_LOG_FILE
    if [ $OUTPUT != 'Already up-to-date.' ]
    then
        echo '\n\n Homebrew upgrade log at '$(date +%d-%m-%Y) >> $BREW_UPDATE_LOG_FILE
        brew upgrade &>> $BREW_UPDATE_LOG_FILE
        brew cleanup &>> $BREW_UPDATE_LOG_FILE
        echo 'Homebrew updated. You can see the last logs at '$BREW_UPDATE_LOG_FILE
    else 
        echo 'Nothing to update.'
    fi
    # This syntax of sed is macOS specific. On Linux, you should not need the empty ''
    sed -i '' -e 's/export LAST_BREW_UPDATE='$OLD_DATE'/export LAST_BREW_UPDATE='$CURRENT_DATE'/g' $ZSHRC_FILE
else 
    echo 'Already updated today.'
fi

##
exit 0