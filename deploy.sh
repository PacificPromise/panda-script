# /bin/bash -l
source ./main.sh

PREFIX=''

get_stage_prompt

git fetch --tags -f

if [[ "$PREFIX" ]]; then
  increment_build_number $PREFIX $STAGE
else
  increment_build_number '' $STAGE
fi
