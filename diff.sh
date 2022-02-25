#!/bin/sh
git diff 6.2-unpatched origin/HEAD ':!README.md' ':!screenshots.png' ':!diff.sh'
