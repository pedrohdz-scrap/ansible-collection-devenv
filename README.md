# ansible-collection-devenv

Clone the project into
`ansible-collection-devenv/ansible_collections/avinode/devenv`.  *Ansible*
collections need to exist in a spcific directory structure while working on
them:

```bash
git clone git@github.com:Avinode/ansible-collection-devenv.git \
    ansible-collection-devenv/ansible_collections/avinode/devenv
```
    

The set up the project environment:

```bash
cd ansible-collection-devenv/ansible_collections/avinode/devenv
./scripts/setup-local-ansible.sh
```

Run tests:

```bash
cd ansible-collection-devenv/ansible_collections/avinode/devenv
source ./.venv/bin/activate

ansible-test sanity --color \
    --docker geerlingguy/docker-debian11-ansible:latest \
    --python 3.9 \
    --exclude scripts/setup-local-ansible.sh \
    --exclude scripts/setup-macports.sh \
    --exclude .gitignore

ansible-test units --color \
    --docker geerlingguy/docker-debian11-ansible:latest \
    --python 3.9

ansible-test integration --color \
    --docker geerlingguy/docker-debian11-ansible:latest \
    --docker-privileged \
    --python 3.9

ansible-test integration --color \
    --docker geerlingguy/docker-ubuntu2004-ansible \
    --docker-privileged \
    --python 3.8

# TODO - Not suported by ansible-test.  Should be in the next ansible-test
# release.
#ansible-test integration --color \
#    --docker geerlingguy/docker-ubuntu2204-ansible \
#    --docker-privileged \
#    --python 3.10

# TODO - Broken.  Need to come back to this.
#ansible-test integration --color \
#    --docker geerlingguy/docker-debian10-ansible:latest \
#    --docker-privileged \
#    --python 3.7
```
