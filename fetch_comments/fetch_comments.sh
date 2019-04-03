#!/bin/bash
source secrets
node fetch_comments/fetch_comments.js > dist/_site/reddit_comment_threads.json
