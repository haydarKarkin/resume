#!/bin/sh

set -ev

setup_git() {
  git config credential.helper "store --file=.git/credentials"
  echo "https://${GH_TOKEN}:@github.com" > .git/credentials

  git pull origin master
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