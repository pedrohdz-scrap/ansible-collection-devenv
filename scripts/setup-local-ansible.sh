#! /bin/bash

#set -o xtrace
set -o errexit
set -o pipefail
set -o nounset

INSTALL_DIR=${GITHUB_WORKSPACE:-$PWD}
VENV_BIN_DIR=${INSTALL_DIR}/.venv/bin

echo "+ INFO - Setting up the project in: $INSTALL_DIR"
if [ -e "${INSTALL_DIR}/.venv" ]; then
  echo "+ ERROR - Already exists: ${INSTALL_DIR}/.venv"
  exit 1
fi

/usr/bin/python3 -m venv "${INSTALL_DIR}/.venv"
"${VENV_BIN_DIR}/pip3" install -U pip
"${VENV_BIN_DIR}/pip3" install ansible pylint flake8 pyright mypi junit-xml
"${VENV_BIN_DIR}/ansible" --version
ruby -r yaml -r json -e 'puts YAML.load($stdin.read).to_json' < galaxy.yml \
    | jq -r '.dependencies | keys | .[]' \
    | xargs -I '{}' "${VENV_BIN_DIR}/ansible-galaxy" collection install -p . '{}'
