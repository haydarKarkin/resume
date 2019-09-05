#!/bin/sh

setup_git() {
  git config --global user.email "haydar.karkin@gmail.com"
  git config --global user.name "Haydar Karkin"
}

commit_website_files() {
  git add dist
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
}

upload_files() {
  git remote add origin https://${GH_TOKEN}@github.com/haydarKarkin/haydarkarkin.github.io.git > /dev/null 2>&1
  git push origin master
}

setup_git
commit_website_files
upload_files