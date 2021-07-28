#!/usr/bin/zsh
ZSHRC_FILE="/Users/tudoroancea/.zshrc"
BREW_UPDATE_DIR="/Users/tudoroancea/Documents/projets/brew-update/"
BREW_UPDATE_LOG_FILE=$BREW_UPDATE_DIR/"log.txt"
LINE=`grep 'LAST_BREW_UPDATE' $ZSHRC_FILE`
OLD_DATE=${LINE:24}
CURRENT_DATE=`date +%d-%m`
if [ $OLD_DATE != $CURRENT_DATE ]
then
    echo "Updating Homebrew..."
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
    sed -i '' 's/LAST_BREW_UPDATE='$DATE'/LAST_BREW_UPDATE='$CURRENT_DATE'/g' $FILE_NAME
fi

exit 0