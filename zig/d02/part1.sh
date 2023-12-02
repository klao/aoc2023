#!/bin/bash

set -euo pipefail

cat in/i02.txt | grep -Ev '[0-9]{3,} |[2-9][0-9] |1[3-9] red|1[4-9] green|1[5-9] blue' | grep -Eo '^Game.*:' | grep -Eo '[0-9]+' | paste -sd+ | bc
