split_version() {
  TAG_NAME=$1
  VERSION_TYPE=$2 # full, all, major, minor, patche, build, increment_patche

  VERSION_NAME_PATH=($(grep -oE '[a-z,0-9,-.+]*' <<<"$TAG_NAME"))
  ARRAY_SIZE=${#VERSION_NAME_PATH[@]}
  VERSION=${VERSION_NAME_PATH[$((ARRAY_SIZE - 1))]}
  ENVIRONMENT=${VERSION_NAME_PATH[$((ARRAY_SIZE - 2))]}
  VERSION_ARRAY=($(grep -oE '[0-9]*' <<<"$VERSION"))

  case $VERSION_TYPE in
  all)
    echo ${VERSION}
    ;;
  full)
    echo "${VERSION_ARRAY[0]}.${VERSION_ARRAY[1]}.${VERSION_ARRAY[2]}"
    ;;
  increment_patche)
    PATCHE_WILL_BUILD=$((VERSION_ARRAY[2] + 1))
    echo "${VERSION_ARRAY[0]}.${VERSION_ARRAY[1]}.${PATCHE_WILL_BUILD}"
    ;;
  major)
    echo ${VERSION_ARRAY[0]}
    ;;
  minor)
    echo ${VERSION_ARRAY[1]}
    ;;
  patche)
    echo ${VERSION_ARRAY[2]}
    ;;
  build)
    echo ${VERSION_ARRAY[3]}
    ;;
  environment)
    echo ${ENVIRONMENT}
    ;;
  esac
}

increment_build_number() {
  STAGE=$2
  if [[ ! "$STAGE" ]]; then
    exit "Missing STAGE environment"
  fi
  PREFIX=''
  if [[ "$1" ]]; then
    PREFIX="$1/"
  fi
  PRO_TAG=$(git tag --sort=-version:refname -l "${PREFIX}production/*" | head -n 1)
  STAGE_TAG=$(git tag --sort=-version:refname -l "${PREFIX}${STAGE}/*" | head -n 1)

  NEW_TAG=''

  if [[ "$STAGE" == "production" ]]; then
    PRO_TAG_FULL=$(split_version $PRO_TAG full)
    PRO_BUILD_NUMBER=$(split_version $PRO_TAG build)
    PRO_BUILD_NUMBER_INCREMENT=$((PRO_BUILD_NUMBER + 1))
    NEW_TAG="${PREFIX}production/v${PRO_TAG_FULL}+${PRO_BUILD_NUMBER_INCREMENT}"
  else
    STAGE_TAG_FULL=$(split_version $PRO_TAG increment_patche)
    STAGE_BUILD_NUMBER=$(split_version $STAGE_TAG build)
    STAGE_BUILD_NUMBER_INCREMENT=$((STAGE_BUILD_NUMBER + 1))
    NEW_TAG="${PREFIX}${STAGE}/v${STAGE_TAG_FULL}+${STAGE_BUILD_NUMBER_INCREMENT}"
  fi
  create_tag $NEW_TAG
}
