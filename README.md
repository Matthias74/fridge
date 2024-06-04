## Fridge

NB: Vite is not working with all the node versions so a `.nvmrc` file should be added at the root
to specify the node version (here: v16.13.0)

Steps:
- bundle install
- nvm use
- yarn install
- gem install foreman

Server: `foreman start -f Procfile.dev`
