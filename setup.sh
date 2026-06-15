#!/usr/bin/env bash
# Bootstrap the LemmaScript starter kit: fetch submodules, install deps, build the CLI.
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -e LemmaScript/package.json ] || [ ! -e .claude/skills/lemmascript/SKILL.md ]; then
  echo "→ initializing submodules"
  git submodule update --init --recursive
fi

echo "→ installing LemmaScript dependencies"
( cd LemmaScript && npm install )

echo "→ building the CLI"
( cd LemmaScript && npm run build )

cat <<'EOF'

✓ Ready. Run lsc from source, e.g.:

    npx tsx LemmaScript/tools/src/lsc.ts regen --backend=dafny path/to/your/file.ts
    dafny verify path/to/your/file.dfy

See README.md and LemmaScript/GETTING_STARTED.md for the full loop.
EOF
