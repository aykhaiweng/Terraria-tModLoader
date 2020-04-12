FROM clearlinux:latest

# Declaring default variables
ENV TEMPDIR "/tmp"
ENV TERRARIA_SERVER_VERSION "1353"
ENV TMODLOADER_VERSION "0.11.6.2"

# Update and install tools
RUN swupd bundle-add unzip wget

# Create working directories
RUN mkdir -p /opt/{terraria-server,tmodloader}

# Download and setup the Terraria Server
RUN cd ${TEMPDIR}
RUN wget "http://terraria.org/server/terraria-server-${TERRARIA_SERVER_VERSION}.zip" -O /terraria-server.zip
RUN wget "https://github.com/tModLoader/tModLoader/releases/download/v${TMODLOADER_VERSION}/tModLoader.Linux.v${TMODLOADER_VERSION}.tar.gz" -O /tmodloader.zip

# Setup the Terraria server in another directory
RUN unzip terraria-server.zip
RUN rm terraria-server.zip
RUN rm -rf 1353/{Mac,Windows}
RUN cp --verbose -a 1353/Linux/* /opt/terraria-server/
RUN rm -rf 1353

# Overriding Terraria with the tModloader files
RUN cd /opt/terraria-server/

# Exposing the port that Terraria runs on by default
EXPOSE 7777
