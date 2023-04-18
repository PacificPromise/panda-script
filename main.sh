source ./src/tag.sh
source ./src/version.sh

init_version_tag() {
  PREFIX=''
  if [ "${1}" ]; then
    PREFIX="$1/"
  fi
  create_tag "${PREFIX}development/v1.0.1+0"
  create_tag "${PREFIX}staging/v1.0.1+0"
  create_tag "${PREFIX}production/v1.0.0+0"
}
