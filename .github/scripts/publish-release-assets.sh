#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <tag-name> <asset-dir> [target-commitish]" >&2
  exit 1
fi

tag_name="$1"
asset_dir="$2"
target_commitish="${3:-main}"
create_release="${CREATE_RELEASE_IF_MISSING:-false}"

if [[ ! -d "$asset_dir" ]]; then
  echo "Asset directory does not exist: $asset_dir" >&2
  exit 1
fi

if ! gh release view "$tag_name" >/dev/null 2>&1; then
  if [[ "$create_release" != "true" ]]; then
    echo "Release '$tag_name' not found and CREATE_RELEASE_IF_MISSING is not true" >&2
    exit 1
  fi

  echo "Creating release ${tag_name} targeting ${target_commitish}..."
  gh release create "$tag_name" --target "$target_commitish" --title "$tag_name" --notes "Automated asset publication."
fi

shopt -s nullglob
assets=( "$asset_dir"/*.skill )
if [[ ${#assets[@]} -eq 0 ]]; then
  echo "No .skill assets found in ${asset_dir}" >&2
  exit 1
fi

echo "Uploading assets to ${tag_name}..."
gh release upload "$tag_name" "${assets[@]}" --clobber
