#!/bin/bash

## cronjob to optimize lossless PNG/JPG images

folders="/home/*/domains/*/public_html"

for folder in $folders; do
  # optimize jpg images created in the last 24 hours
  find "$folder" -ctime 0 -type f \( -iname "*.jpg" -o -iname "*.jpeg" \) -print0 | xargs -0 jpegoptim --preserve --strip-all >> /var/log/jpg-png-cron.log 2>&1
  # optimize png images created in the last 24 hours
  find "$folder" -ctime 0 -type f  -iname '*.png' -print0 | xargs -0 optipng -o7 -strip all  >> /var/log/jpg-png-cron.log 2>&1
done
