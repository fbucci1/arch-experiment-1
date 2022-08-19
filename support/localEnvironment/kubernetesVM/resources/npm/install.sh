#!/bin/bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#Installs npm 14.15.0. This is the latest version compatible with angular-cli as of Aug 2022.
nvm install v14.15.0

echo "npm $(npm -v)"
echo "node $(node -v)"

npm cache clean --force
