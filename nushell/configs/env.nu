# env.nu - loaded before config.nu, for environment setup.
# Shared env vars and PATH entries with zsh live in $DOTFILES/shared/.

# Bootstrap anchor - must match zsh's .zshenv
$env.DOTFILES = ($env.HOME | path join "dotfiles")

# Shared KEY=value env vars ($HOME in values is expanded)
open ($env.DOTFILES | path join "shared" "env")
| lines
| where { |line| let t = ($line | str trim); $t != "" and not ($t | str starts-with "#") }
| parse "{key}={value}"
| each { |row| { ($row.key): ($row.value | str replace --all "$HOME" $env.HOME) } }
| into record
| load-env

# Shared PATH entries (appended, deduplicated)
$env.PATH = ($env.PATH | append (
    open ($env.DOTFILES | path join "shared" "paths")
    | lines
    | where { |line| let t = ($line | str trim); $t != "" and not ($t | str starts-with "#") }
    | each { |line| $line | str replace --all "$HOME" $env.HOME }
) | uniq)

# Newest nvm-installed node on PATH (~0ms, no version-manager init). nvm itself
# is zsh-only; nu just needs the binaries, for itself and for spawned tools
# (e.g. Neovim's node provider). zsh does the equivalent via glob in .zshrc.
let node_versions = ($env.HOME | path join ".nvm" "versions" "node")
if ($node_versions | path exists) {
    let latest_bin = (ls $node_versions | sort-by --natural { path basename } | last | get name | path join "bin")
    $env.PATH = ($env.PATH | prepend $latest_bin)
}

# Machine-local overrides, if they exist (same pattern as .zshenv.local).
# Env vars only — defs/aliases would not escape the if-block's scope.
const local_env = "~/.env.nu.local"
if ($local_env | path exists) { source $local_env }
