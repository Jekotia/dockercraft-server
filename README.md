Please note that this document is a work-in-progress.

### Project Goal

The primary goal of this project is to achieve server-as-an-application levels of consistency, stability, and reliability, for the Java edition of Minecraft. The primary means this project will utilise are:

Self-containment; the container will be configurable to a users' use-case, but will incorporate:
* best-practice defaults for:
  * Java runtime version, binaries, etc
  * Java arguments
* volume mounts for:
  * world data
  * server configuration
  * server plugins/mods
  * minecraft_server.jar
  * logfiles

Custom scripts written specifically for this image will be utilised, with a secondary project goal of utilising Docker's healthcheck system (for example, this could be achieved with a monitoring daemon running within the container) to detect when the Minecraft server enters an unhealthy state and attempt to restart it as gracefully as the situation will allow.
