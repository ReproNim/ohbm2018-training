#!/bin/bash
#
# Convert BIDS events.tsv to FSL's EV3 files

set -e
set -u

# little helper
printf '1.0\n%.0s' {1..32} > ones.txt


subj="$1"
events="$2"

echo $subj
for r in $(seq 1); do
  echo $r
  mkdir -p $subj/onsets/run-$r
  for c in face scene body house object scramble; do
    grep $c \
      "$events" \
      | cut -f 1,2 \
      | paste - ones.txt \
      > $subj/onsets/run-$r/$c.txt
  done
done

rm ones.txt
