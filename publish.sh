#!/bin/bash

git add --all
git commit -m "change content"
# checkout on server
ssh root@bigtheta.org 'bash -s' < ./update.sh
