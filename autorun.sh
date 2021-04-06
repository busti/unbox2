until ping -c1 google.com >/dev/null 2>&1; do
  echo "Waiting for network..."
  sleep 1
done

sleep 5

hwhash=$(dmidecode | grep -A3 '^System Information' | tr -dc '[:alnum:]' | sha256sum | awk '{print $1}')
echo "Hardware Hash $hwhash"

git clone https://github.com/busti/unbox2
if [ -d /root/unbox2 ]; then
  remote=$(grep $hwhash /root/unbox2/repos.txt | cut -f 2)
else
  remote=$(grep $hwhash /etc/repos.txt | cut -f 2)
fi

if [ -z "$remote" ]; then
  echo $hwhash > hwhash.txt
  echo -n "git repository url: "
  read remote
fi

if [ -z "$remote" ]; then
  exit 1
fi

echo "Cloning $remote"
git clone --recurse-submodules "$remote" repo

if [[ ! -e repo/install.sh ]]; then
  echo no entry found;
  exit 1;
fi

sudo /bin/sh repo/install.sh
