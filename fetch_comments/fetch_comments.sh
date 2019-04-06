#!/bin/bash
site_url=''
# shellcheck disable=SC1091
source ../secrets
wget -O ../dist/_site/reddit_comment_threads.json 'https://www.reddit.com/search.json?q=site%3A"'"$site_url"'"'
