#!/bin/sh

/bin/sh -c "docker inspect -f='{{index .Config.Labels \"copy2git.$2\"}}' $1"