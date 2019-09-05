#!/bin/sh

set -ev

USERNAME="haydarKarkin"
PROJECT_NAME="haydarkarkin.github.io"
REPO="${USERNAME}/${PROJECT_NAME}"

setup_git() {
  git config credential.helper "store --file=.git/credentials"
  echo "https://${GH_TOKEN}:@github.com" > .git/credentials
}

setup_other_repo() {
  echo "${REPO} cloning..."
  git clone https://${GH_TOKEN}@github.com/${REPO}.git
  echo "${REPO} cloned"
}

commit_static_files_and_push() {
  echo "Moving generated static files..."
  mv dist/* ${PROJECT_NAME}/
  
  echo "Commiting changes..."
  cd ${PROJECT_NAME}
  git add .
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
  echo "Commited change"
  
  echo "Pushing changes..."
  git push origin master
  echo "Pushed changes"
}

setup_git
setup_other_repo
commit_static_files_and_push
