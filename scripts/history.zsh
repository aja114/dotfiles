# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# No shared history between shells
setopt share_history
# unsetopt share_history

# Ignore duplicates
setopt histignorealldups

export HISTORY_IGNORE="ls|cl|clear|history"
export HISTSIZE=10000