timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

restore-vbox(){
  vm=$1
  vbm controlvm $vm poweroff
  vbm snapshot $vm restorecurrent
  vbm startvm $vm --type headless
}

restore-vbox-snap(){
  vm=$1
  snap=$2
  vbm controlvm $vm poweroff
  vbm snapshot $vm restore $snap
  vbm startvm $vm --type headless
}

rm-dry(){
    arg=$1
    if [[ -z arg ]]; then
        echo "no argument passed"
        return 1
    elif [[ -f $arg ]]; then
        echo rm $arg
    elif [[ -d $arg ]]; then
        find $arg -type f -maxdepth 1 -exec echo rm {} \;
        find $arg -type d -maxdepth 2 -exec echo rm {} \;
    else
        echo "passed argument $arg was not found on the fs"
        return 1
    fi
}

# Some extra prompt commands
function p10k-on-pre-prompt() {
  # Script to show the python version on the prompt of the virtual env when activated and not the global pyenv
  if [[ -z $VIRTUAL_ENV ]]; then
    p10k display '1/right/pyenv'=show
  else
    p10k display '1/right/pyenv'=hide
  fi

  if [[ $(hostname) == de01mmaa033.* ]]; then
    p10k display '1/left/context'=hide
  fi
}

# Function to tunnel to harmattan with GPU node
function hmt-tunnel() {
    kubectl --context tailscale-operator-k8s-stag-swedencentral.cheetah-koi.ts.net -n vortex port-forward pod/mistral-7b-h100-gpu-79db4dbd68-4g99v ${1}:8080
}

# Grep through pods
function grepods(){
    podName=${1}
    shift
    kubectl get pods "${@}" | grep ${podName} --color=always
}

function tag-subdir(){
  SUBDIR=$1
  ALL_TAGS=$2
  
  if [ -z "$ALL_TAGS" ]; then
      tags=$(git tag --sort=creatordate | grep -E "^v\d+\.\d+\.\d+$" | tail -n 50)
  else
      tags=$(git tag --sort=creatordate | tail -n 50)
  fi;

  prev_tag=""
  echo "$tags" | while IFS= read -r tag; do
      if [ -n "$prev_tag" ]; then
          DIFF=$(git diff "$prev_tag" "$tag" -- "$SUBDIR")
          # If the diff is not empty show the tag
          if [ ! -z "$DIFF" ]; then
              echo "$tag"
          fi
      fi
      prev_tag="$tag"
  done
}

function diff-subdir(){
  REF1=$1
  REF2=$2
  SUBDIR=$3
  
  git log --oneline --decorate --graph $REF1 $REF2 -- $SUBDIR
}

# show what is in recipe at a certain version
show-recipe() {
    local tag=$1
    local model_name=$2

    # Check if both arguments are provided
    if [[ -z "$tag" || -z "$model_name" ]]; then
        echo "Usage: show_recipe <tag> <model_name>"
        return 1
    fi

    # Run the git show command
    git show "recipes/${tag}:model-delivery/recipes/${model_name}.yaml" | cat
}

# Show all recipe versions
show-recipe-version(){
	git for-each-ref --sort=creatordate --format '%(refname) %(creatordate)' refs/tags | sed 's/refs\/tags\///' | grep recipes/
}

ksecret(){
  cat | jq ".data.$1 | @base64d"
}

git_copy_branch_to() {
  if [ "$#" -lt 2 ]; then
    echo "Error: This function requires at least 2 arguments." >&2
    return 1  # Exit the function with an error status
    # Alternatively, use `exit 1` to exit the entire script
  fi
  BRANCH_NAME=$1
  TGT_FOLDER=$2

  # make sure branch transferred is on top of HEAD
  if [ -n "$(git status --porcelain)" ]; then
    echo "untracked files in src would mess up copy. aborting"
    return 1
  fi

  # go to target destination. Pull from main
  pushd $2
  if [ -n "$(git status --porcelain)" ]; then
    echo "untracked files in target would mess up copy. aborting"
    popd
    return 1
  else
    git checkout main && git pull && git checkout -b $1 || { echo "Error: Command failed." >&2; popd; return 1; }
  fi
  popd

  uv run python -m tools.copy.copy . $2
  git checkout main
  git pull

  pushd $2
  git add -A && git commit -m "Transfer $1"
  git merge main
  git push  --set-upstream origin $1
  git checkout main
  popd
}
