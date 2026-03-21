#!/usr/bin/env bash

set -euo pipefail

output_dir="${1:-dist}"
mkdir -p "$output_dir"

shopt -s nullglob
for skill_file in */SKILL.md; do
  skill_dir="$(dirname "$skill_file")"
  archive_path="${output_dir}/${skill_dir}.skill"
  echo "Packaging ${skill_dir}..."
  zip -rq "$archive_path" "$skill_dir"
  echo "  -> ${archive_path}"
done
