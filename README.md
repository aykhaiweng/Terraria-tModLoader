tModLoader-powered Terraria server!
=====

An exercise for some Docker practice and boilerplating a tModLoader server for Terraria. It works, atleast.


### Getting the requirements together
First off, let's get Docker installed in your system. You can follow the install instructions for your OS (but I've tested mine on Ubuntu 19.04)
* [Docker](https://docs.docker.com/engine/install/)


### Starting the server
Once Docker is installed, you can create a quick script in a directory of your choosing (I use `/opt/terraria/`, but whatever is conveninent, just don't do it in `~` or `/`)

#### Creating the start.sh script
`echo echo 'sudo docker run --rm -it -p 7777:7777 -v $(pwd)/mnt/share/:/.local/share/ aykhaiweng:terraria-tmodloader --log-opt max-size=200k' > start.sh`

A little break down on what the above does:
* `--rm` will delete the container when it stops running
* `-it` runs the Docker container in Interactive mode (Recommended for creating worlds and setting up the mods)
* `-v $(pwd)/mnt/share/:/.local/share/` creates a mount point at the `share` folder in the container that's going to hold all the configuration, world, logs and mod files.
* `aykhaiweng:terraria-tmodloader` is just the name of the image on Docker Hub.
* `--log-opt max-size=200k` will constrain the log size to 200kB. (this last bit is directly forwarded to the command that launches the tModLoader server.

#### Mark the executable and run it
Now that we have our script, we need to mark it as an executable (just for convenience sake):
`chmod +x start.sh`

And run it:
`./start.sh`

#### TLDR;
```
docker run --rm -it -p 7777:7777 -v $(pwd)/mnt/share/:/.local/share/ aykhaiweng:terraria-tmodloader --log-opt max-size=200k
```

### Updating mods
```
docker run --rm -it -p 7777:7777 --entrypoint="update_mods" -v $(pwd)/mnt/share/:/.local/share/ aykhaiweng:terraria-tmodloader
```


### Links
* [Terraria](http://terraria.org/)
* [tModLoader](https://forums.terraria.org/index.php?threads/1-3-tmodloader-a-modding-api.23726/)
