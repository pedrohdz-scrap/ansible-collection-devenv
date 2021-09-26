# ansible-collection-devenv

```bash
python3.9 -m venv .venv
source .venv/bin/activate
pip install -U pip
pip install ansible ansible-lint 'molecule[docker]' yamllint

cat galaxy.yml | ruby -r yaml -r json -e 'puts YAML.load($stdin.read).to_json' \
    | jq -r '.dependencies | keys | .[]' \
    | xargs -i ansible-galaxy collection install -p . '{}'
```

Run tests:

```bash
cd ansible_collections/avinode/devenv/

ansible-test sanity --docker default
ansible-test units --docker default

ansible-test integration --docker ubuntu2004 \
    --python-interpreter /usr/bin/python3

ansible-test integration \
    --docker geerlingguy/docker-debian10-ansible:latest \
    --python-interpreter /usr/bin/python3
```
