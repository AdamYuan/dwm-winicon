#!/bin/sh
git diff 6.3 origin/HEAD ':!README.md' ':!screenshots.png' ':!diff.sh'
