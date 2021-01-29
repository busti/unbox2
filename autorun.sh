echo -n "git repository url: "
read remote
echo $remote

git clone --recurse-submodules "$remote" repo

if [[ ! -e repo/entry.sh ]]; then
  echo no entry found;
  exit 1;
fi

sudo /bin/sh repo/entry.sh
