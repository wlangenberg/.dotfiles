#!/bin/sh

pages_free=$(vm_stat | awk '/Pages free/ {print $3}' | tr -d '.')
pages_inactive=$(vm_stat | awk '/Pages inactive/ {print $3}' | tr -d '.')
pages_speculative=$(vm_stat | awk '/Pages speculative/ {print $3}' | tr -d '.')

page_size=$(vm_stat | head -1 | awk '{print $8}')

free_mem=$(echo "($pages_free + $pages_inactive + $pages_speculative) * $page_size / 1024 / 1024 / 1024" | bc)
total_mem=$(echo "$(sysctl -n hw.memsize) / 1024 / 1024 / 1024" | bc)

used_mem=$(echo "$total_mem - $free_mem" | bc)
used_mem_int=$used_mem

if [ "$used_mem_int" -gt 14 ]; then
    sketchybar --set "$NAME" label="${used_mem}/${total_mem}" icon.color=0xfff7768e
else
    sketchybar --set "$NAME" label="${used_mem}/${total_mem}" icon.color=0xffffffff
fi

