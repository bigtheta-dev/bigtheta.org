#!/bin/bash

git add --all
git commit -m "change content"
git push
# checkout on server
ssh root@bigtheta.org 'bash -s' < scr/update.sh
