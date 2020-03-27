Welcome to Comic App by David Knudson
This app is powered with data from the Comic Vine API https://comicvine.gamespot.com/
Special thanks to Ix for not letting me drown

This app provides the following functions:
1. Log in / create a new user
2. Add an item to favorites
3. Delete an item from favorites
4. View favorites
5. Look up a short bio on the character entered
6. Look up a short bio on the creator entered
7. Get a list of all characters credited to the creator entered
8. Exits the application

To install:
1. Fork and clone this repo
2. Run "bundle install"
3. Run "rake db:create_migration NAME="create_users" and "rake db:create_migration NAME="create_favorites"
4. Run "rake db:migrate"
5. Run "ruby bin/run.rb"
