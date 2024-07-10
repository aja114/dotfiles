# pyenv setup
# only exporting env var since the pyenv
# initialisation happens using the pyenv omz plugin
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH=$(pyenv root)/shims:$PATH

# poetry setup
export "PATH=$HOME/.poetry/bin:$PATH"

# Tell python not to generate pyc files
export PYTHONDONTWRITEBYTECODE=1

# set python debugger to ipdb
export PYTHONBREAKPOINT=ipdb.set_trace

# Only allow pip to install in venv
export PIP_REQUIRE_VIRTUALENV=true
