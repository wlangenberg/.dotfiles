#!/bin/sh

# Set number of logical CPU cores
cores=8

# Get total raw CPU usage across all processes
raw_total_cpu=$(ps -A -o %cpu | awk '{s+=$1} END {print s}')

# Normalize total CPU usage
total_cpu=$(awk -v raw="$raw_total_cpu" -v cores="$cores" 'BEGIN { printf "%.1f", raw / cores }')

# Get top process by CPU usage
read top_cpu top_cmd <<< $(ps -A -o %cpu,comm | tail -n +2 | sort -nr | head -n 1)
top_process=$(basename "$top_cmd")

# Normalize top process CPU usage
top_cpu_normalized=$(awk -v cpu="$top_cpu" -v cores="$cores" 'BEGIN { printf "%.1f", cpu / cores }')

sketchybar --set "$NAME" label="$top_process | ${top_cpu_normalized}% (${total_cpu}%)"

# old
# sketchybar --set "$NAME" label="$(ps -A -o %cpu | awk '{s+=$1} END {s /= 8} END {printf "%.1f%%\n", s}')"
