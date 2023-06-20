get_id_lc_task() {
  TAG_NAME=$(git describe --tags)
  delimiter="/"
  RESULT=$(echo $TAG_NAME | cut -d "$delimiter" -f 2)
  TAG_ENV_NAME_TAIL_2=$(git tag -l -n "$1/${RESULT}/*" --sort=creatordate --format "%(refname:short)" | tail -2)
  eval "TAG_ENV_NAME_TAIL_2=($TAG_ENV_NAME_TAIL_2)"
  LOGS=$(git log --oneline $TAG_ENV_NAME_TAIL_2[1]...$TAG_ENV_NAME_TAIL_2[2])
  LOGS=$(echo $LOGS | grep --only-matching --extended-regexp 'LC-[0-9]*')
  LOGS=$(echo "$LOGS" | awk '{for (i=1;i<=NF;i++) if (!a[$i]++) printf("%s, ",$i)}')
  LOGS="${LOGS//LC-0, /}"
  # Trim string
  LOGS="${LOGS%"${LOGS##*[![:space:]]}"}"
  # Remove commas if it is the last character
  if [[ "${LOGS: -1}" == "," ]]; then
    # Remove the comma
    LOGS="${LOGS%,}"
  fi
  echo $LOGS
}
