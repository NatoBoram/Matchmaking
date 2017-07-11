#!/bin/sh
curl -o License.txt --progress-bar https://raw.githubusercontent.com/SpigotMCUpdater/SpigotMC-Updater/master/LICENSE
clear
read -t60 -n1 -r -p "SpigotMC Updater : Updates everything Spigot-related. Copyright (C) 2016 NatoBoram

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.
"
curl -o BuildTools.jar --progress-bar https://hub.spigotmc.org/jenkins/job/BuildTools/lastBuild/artifact/target/BuildTools.jar
curl -o BungeeCord.jar --progress-bar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/bootstrap/target/BungeeCord.jar
java -jar BuildTools.jar
curl -o BuildTools.sh --progress-bar https://raw.githubusercontent.com/SpigotMCUpdater/SpigotMC-Updater/master/BuildTools.sh
exit