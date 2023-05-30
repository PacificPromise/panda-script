rm -rf index.sh

search_dir=./src
for entry in "$search_dir"/*; do
  while read -r line; do echo $line >>index.sh; done <$entry
done
