split_version() {
  TAG_NAME=$1
  VERSION_TYPE=$2 # major, minor, patches, build

  VERSION_NAME_PATH=($(grep -oE '[a-z,0-9,-.+]*' <<<"$TAG_NAME"))
  ARRAY_SIZE=${#VERSION_NAME_PATH[@]}
  VERSION=${VERSION_NAME_PATH[$((ARRAY_SIZE - 1))]}
  VERSION_ARRAY=($(grep -oE '[0-9]*' <<<"$VERSION"))

  case $VERSION_TYPE in
  major)
    echo ${VERSION_ARRAY[0]}
    ;;
  minor)
    echo ${VERSION_ARRAY[1]}
    ;;
  patches)
    echo ${VERSION_ARRAY[2]}
    ;;
  build)
    echo ${VERSION_ARRAY[3]}
    ;;
  esac
}

increment_build_number() {
  if [[ ! "$2" ]]; then
    exit "Missing STAGE environment"
  fi
  PREFIX=''
  if [[ "$1" ]]; then
    PREFIX="$1/"
  fi
  PRO_TAG=$(git tag -l --sort=-version:refname "${PREFIX}production/*" | head -n 1)
  STAGE_TAG=$(git tag -l --sort=-version:refname "${PREFIX}${2}/*" | head -n 1)
  # echo $PRO_TAG
  # echo $STAGE_TAG

  split_version $PRO_TAG build
}
