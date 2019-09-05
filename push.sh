#!/bin/sh

set -ev

setup_git() {
  git config credential.helper "store --file=.git/credentials"
  echo "https://${GH_TOKEN}:@github.com" > .git/credentials
}

commit_website_files() {
  git add dist
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
}

upload_files() {
  git remote add origin-site https://${GH_TOKEN}@github.com/haydarKarkin/haydarkarkin.github.io.git > /dev/null 2>&1
  git pull origin-site master
  git push origin-site master
}

setup_git
commit_website_files
upload_files