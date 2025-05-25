#!/bin/sh

uptime -p | awk '{
  for(i=1;i<=NF;i++) {
    if($i ~ /day/) printf "%sd ", $(i-1);
    else if($i ~ /hour/) printf "%sh ", $(i-1);
    else if($i ~ /minute/) printf "%sm", $(i-1);
  }
}'