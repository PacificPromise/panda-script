get_funny_idiom() {
  RANDOM_FUNNY_IDIOMS_GIST_URL=https://gist.githubusercontent.com/tuanngocptn/9fabb1979e5b29eca84bce28c6b8d080/raw/random-idioms-vi.sh
  RESULT="$(bash -c "$(curl -fsSL ${RANDOM_FUNNY_IDIOMS_GIST_URL})")"
  echo $RESULT
}
