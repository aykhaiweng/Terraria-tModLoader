FROM clearlinux:latest

# Adding meta
LABEL	maintainer="Au Yeong Khai Weng <aykhaiweng@gmail.com>" \
		description="Terraria + tModLoader v0.11.6.2" \
		created_date="13th April 2020"

# Declaring default variables
ENV TERRARIA_SERVER_VERSION "1353"
ENV TMODLOADER_VERSION "0.11.6.2"

# Update and install tools
RUN swupd bundle-add unzip wget

# Make the opt directory if it doesn't exist
RUN mkdir -p /opt

# Download and setup the Terraria Server
RUN wget "http://terraria.org/server/terraria-server-${TERRARIA_SERVER_VERSION}.zip" -O /tmp/terraria-server.zip
RUN wget "https://github.com/tModLoader/tModLoader/releases/download/v${TMODLOADER_VERSION}/tModLoader.Linux.v${TMODLOADER_VERSION}.tar.gz" -O /tmp/tmodloader.tar.gz

# Setup the Terraria server in another directory
RUN unzip /tmp/terraria-server.zip -d /opt
RUN rm /tmp/terraria-server.zip

# Change the name of that annoying directory
RUN mv /opt/${TERRARIA_SERVER_VERSION}/Linux /opt/terraria-server/
RUN rm -rf /opt/${TERRARIA_SERVER_VERSION}

# Overriding Terraria with the tModloader files
RUN tar -xf /tmp/tmodloader.tar.gz -C /opt/terraria-server

# Do necessary modifications to the App Folder
RUN chmod u+x /opt/terraria-server/tModLoaderServer*
RUN chmod u+x /opt/terraria-server/TerrariaServer*

# Exposing the port that Terraria runs on by default
EXPOSE 7777

ENTRYPOINT ["/opt/terraria-server/tModLoaderServer"]
