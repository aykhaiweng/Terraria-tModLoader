FROM clearlinux:latest

# Declaring default variables
ENV TEMPDIR "/tmp"
ENV APP_LOCATION "/opt/terraria-server"
ENV TERRARIA_SERVER_VERSION "1353"
ENV TMODLOADER_VERSION "0.11.6.2"

# Update and install tools
RUN swupd bundle-add unzip wget

# Create working directories
RUN mkdir -p ${APP_LOCATION}

# The next few sections will happen in the tmp dir
RUN cd ${TEMPDIR}

# Download and setup the Terraria Server
RUN wget "http://terraria.org/server/terraria-server-${TERRARIA_SERVER_VERSION}.zip" -O /terraria-server.zip
RUN wget "https://github.com/tModLoader/tModLoader/releases/download/v${TMODLOADER_VERSION}/tModLoader.Linux.v${TMODLOADER_VERSION}.tar.gz" -O /tmodloader.tar.gz

# Setup the Terraria server in another directory
RUN unzip terraria-server.zip
RUN rm terraria-server.zip
RUN rm -rf 1353/{Mac,Windows}
RUN cp --verbose -a 1353/Linux/* ${APP_LOCATION}
RUN ls ${APP_LOCATION}
RUN rm -rf 1353

# Overriding Terraria with the tModloader files
RUN tar -xvf tmodloader.tar.gz -C ${APP_LOCATION}
RUN ls ${APP_LOCATION}

# Exposing the port that Terraria runs on by default
EXPOSE 7777
