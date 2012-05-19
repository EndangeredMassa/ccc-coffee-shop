#!/bin/sh

lsof -i tcp:1337 | awk '{print $2}' | tail -1 | xargs -I {} kill {}

