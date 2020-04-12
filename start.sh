#/bin/bash

sudo docker run --rm -it -p 7777:7777 -v $(pwd)/mnt/share/:/.local/share/ aykhaiweng/terraria-tmodloader --log-opt max-size=200k
