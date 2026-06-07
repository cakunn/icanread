#!/bin/sh
set -eu

required_docs="PRD.md ARCHITECTURE.md DESIGN.md README.md AGENTS.md CHANGELOG.md ACS.md"

for document in $required_docs; do
  if [ ! -s "$document" ]; then
    echo "Missing or empty required document: $document" >&2
    exit 1
  fi
done

grep -q '^## \[Unreleased\]' CHANGELOG.md
grep -q '^## Current Capabilities' ACS.md
grep -q '^## Known Limitations' ACS.md
grep -q 'Definition of Done' AGENTS.md

echo "Documentation contract checks passed."
