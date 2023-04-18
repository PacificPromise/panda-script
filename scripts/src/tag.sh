create_tag() {
  TAG_NAME=$1
  echo "New release for $TAG_NAME at $(date '+%d/%m/%Y %H:%M:%S')" >>release.txt
  CURRENT_BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
  HEAD_HASH="$(git rev-parse --short HEAD)"
  {
    git add release.txt &&
      git commit -m "LC-0/build: New release for $TAG_NAME at $(date '+%d/%m/%Y %H:%M:%S')" &&
      git push origin $CURRENT_BRANCH &&
      git tag -a $TAG_NAME -m "New release for $TAG_NAME" &&
      git push origin $TAG_NAME
  } || {
    git reset --soft $HEAD_HASH
    git checkout $HEAD_HASH release.txt
  }
}

delete_tag() {
  git tag -d "$1"
  git push --delete origin "$1"
}
