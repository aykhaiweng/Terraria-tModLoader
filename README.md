tModLoader-powered Terraria server!
=====

An exercise for some Docker practice and boilerplating a tModLoader server for Terraria. This has been tested on a remote Ubuntu 19.04 server.

### Requirements
[Docker](https://docs.docker.com/engine/install/)

### Starting the server
```
docker run --rm -it -p 7777:7777 -v $(pwd)/mnt/share/:/.local/share/ aykhaiweng:terraria-tmodloader --log-opt max-size=200k
```

### Updating mods
```
docker run --rm -it -p 7777:7777 --entrypoint="update_mods" -v $(pwd)/mnt/share/:/.local/share/ aykhaiweng:terraria-tmodloader
```

### Links
[Terraria](http://terraria.org/)
[tModLoader](https://forums.terraria.org/index.php?threads/1-3-tmodloader-a-modding-api.23726/)
