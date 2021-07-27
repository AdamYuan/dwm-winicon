#!/bin/sh
git diff 6.2 origin/HEAD ':!README.md' ':!screenshots.png' ':!diff.sh'
