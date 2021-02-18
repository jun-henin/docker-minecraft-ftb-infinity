FROM java:8

ENV FTB_INFINITY_URL https://api.modpacks.ch/public/modpack/23/99/server/linux
ENV LAUNCHWRAPPER net/minecraft/launchwrapper/1.12/launchwrapper-1.12.jar

RUN curl -SL $FTB_INFINITY_URL -o /tmp/serverinstall && \
    /tmp/serverinstall -d /opt/minecraft && \
    mkdir -p /opt/minecraft/$(dirname libraries/${LAUNCHWRAPPER}) && \
    curl -S https://libraries.minecraft.net/$LAUNCHWRAPPER -o /opt/minecraft/libraries/$LAUNCHWRAPPER && \
    curl -SL https://minecraft.curseforge.com/projects/dynmapforge/files/2307078/download -o /opt/minecraft/mods/Dynmap-2.3-forge-1.7.10.jar && \
    find /opt/minecraft -name "*.log" -exec rm -f {} \; && \
    rm -rf /opt/minecraft/ops.* /opt/minecraft/whitelist.* /opt/minecraft/logs/* /tmp/*

ADD eula.txt /opt/minecraft/eula.txt

ENV MINECRAFT_VERSION 1.7.10
ENV MINECRAFT_OPTS -server -Xms2048m -Xmx3072m -XX:MaxPermSize=256m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC
ENV MINECRAFT_STARTUP_JAR FTBServer-1.7.10-1614.jar

VOLUME /opt/minecraft/world

EXPOSE 25566
EXPOSE 8123

CMD bash /opt/minecraft/ServerStart.sh
