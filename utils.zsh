# Guard: prevent sourcing in interactive shells
if [[ -o interactive ]]; then
  echo "Error: utils.zsh is for internal use by dotfiles scripts only" >&2
  return 1
fi

# ========================================
# Color Definitions
# ========================================
__dotfile_red='\033[0;31m'
__dotfile_green='\033[0;32m'
__dotfile_yellow='\033[1;33m'
__dotfile_blue='\033[0;34m'
__dotfile_magenta='\033[0;35m'
__dotfile_cyan='\033[0;36m'
__dotfile_white='\033[1;37m'
__dotfile_nc='\033[0m' # No Color

# ========================================
# Message Functions
# ========================================
script_name=""

# Set the script name for headers
__dotfile_set_script_name() {
    script_name=$1
}

# Print a section header
__dotfile_section_header() {
    local title=$1
    local step=$2
    local total=$3
    echo
    echo -e "${__dotfile_blue}========================================${__dotfile_nc}"
    echo -e "${__dotfile_blue}[${step}/${total}] ${title}${__dotfile_nc}"
    echo -e "${__dotfile_blue}========================================${__dotfile_nc}"
}

# Print an info message (what's happening)
__dotfile_info() {
    echo -e "  ${__dotfile_yellow}→ ${1}${__dotfile_nc}"
}

# Print a success message
__dotfile_success() {
    echo -e "  ${__dotfile_green}✓ ${1}${__dotfile_nc}"
}

# Print a warning message
__dotfile_warning() {
    echo -e "  ${__dotfile_yellow}⚠ ${1}${__dotfile_nc}"
}

# Print an error message
__dotfile_error() {
    echo -e "  ${__dotfile_red}✗ ${1}${__dotfile_nc}"
}

# Print a skip message
__dotfile_skip() {
    echo -e "  ${__dotfile_yellow}→ Skipping ${1}${__dotfile_nc}"
}

# ========================================
# Plugin Management
# ========================================
__dotfile_add_zsh_plugin() {
    git_url=$1
    plugin_name=$(basename -s .git "$git_url")
    plugin_dest=${ZSH_CUSTOM}/plugins/${plugin_name}
    if [ -d "$plugin_dest" ]; then
        cd "$plugin_dest"
        git pull
    else
        git clone $git_url ${ZSH_CUSTOM}/plugins/${plugin_name}
    fi
}