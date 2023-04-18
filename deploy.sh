title="Chon moi truong build:"
prompt="Lua chon:"
options=("Development" "Staging" "Production")

echo "$title"
PS3="$prompt "
ENV=""
select opt in "${options[@]}" "Thoat"; do
  case "$REPLY" in
  1) echo "Lua chon build $opt" && ENV="dev" && break ;;
  2) echo "Lua chon build $opt" && ENV="stg" && break ;;
  3) echo "Lua chon build $opt" && ENV="pro" && break ;;
  $((${#options[@]} + 1)))
    echo "Goodbye!"
    exit 0
    ;;
  *)
    echo "Sai lua chon. chon lai."
    continue
    ;;
  esac
done
git fetch --tags -f