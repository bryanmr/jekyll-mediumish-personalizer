#!/bin/bash
site_url=''
bucket_short_name=''
bucket_dir=''
set -xuEeo pipefail

# shellcheck disable=SC1091
source ../secrets
gcloud functions deploy fetchComments --runtime nodejs8 --set-env-vars site_url="$site_url",bucket_short_name="$bucket_short_name",bucket_dir="$bucket_dir" --trigger-topic get-comments

echo "Waiting for function to propogate"
sleep 30
gcloud pubsub topics publish get-comments --message="Refresh"

echo "Running logs for first time"
gcloud functions logs read
echo "Running logs for second time"
sleep 30
gcloud functions logs read
echo "Running logs for third and last time"
sleep 30
gcloud functions logs read
