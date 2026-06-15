# LemmaScript Starter Kit

A self-contained kit for verifying TypeScript with [LemmaScript](https://github.com/midspiral/LemmaScript):
the toolchain source plus the Claude Code skills that drive it, bundled as git submodules.

## What's inside

| Path | Source | What it is |
|------|--------|------------|
| `LemmaScript/` | [midspiral/LemmaScript](https://github.com/midspiral/LemmaScript) | The verifier — compiles annotated TypeScript to Dafny or Lean 4. CLI: `lsc`. |
| `.claude/skills/` | [midspiral/lemmascript-skills](https://github.com/midspiral/lemmascript-skills) | Claude Code skills: `lemmascript` (annotation grammar + `SPEC.md`), `design-doc`, `proof-review`, `verified-codebase`. |

Both are git submodules — see [Updating](#updating).

## Prerequisites

- **Node.js ≥ 18**
- **Dafny ≥ 4.x** — for the Dafny backend ([install](https://github.com/dafny-lang/dafny))
- **Lean 4** (`v4.24.0`, optional) — only if you use the Lean backend; managed via `elan`/`lake`
- **git**

## Get the kit

The kit uses submodules, so clone recursively:

```sh
git clone --recurse-submodules https://github.com/midspiral/lemmascript-kit.git
cd lemmascript-kit
```

Already cloned without `--recurse-submodules`? Pull the submodules in:

```sh
git submodule update --init --recursive
```

## Bootstrap

```sh
./setup.sh          # inits submodules, installs deps, builds the CLI
```

Run `lsc` from source through `tsx`:

```sh
npx tsx LemmaScript/tools/src/lsc.ts <gen|regen|check|info> --backend=dafny path/to/file.ts
```

> The skills write the CLI as `npx lsc` — that form needs the
> [`lemmascript`](https://www.npmjs.com/package/lemmascript) npm package installed (or `npm link`).
> In this source kit, substitute `npx tsx LemmaScript/tools/src/lsc.ts`.

## The verification loop

```sh
# generate Dafny next to your TS, preserving any hand-written proofs
npx tsx LemmaScript/tools/src/lsc.ts regen --backend=dafny src/domain.ts

# verify
dafny verify src/domain.dfy
```

`regen` writes `domain.dfy.gen` (generated — don't edit) and `domain.dfy` (yours — add lemmas,
ghost predicates, and loop invariants here). See [`LemmaScript/GETTING_STARTED.md`](LemmaScript/GETTING_STARTED.md)
for the full walkthrough and [`LemmaScript/SPEC.md`](LemmaScript/SPEC.md) for the annotation grammar.

## Using the skills with Claude Code

Start Claude Code from the kit root: the skills under `.claude/skills/` are auto-discovered. The
`lemmascript` skill is the annotation-grammar reference; `design-doc`, `proof-review`, and
`verified-codebase` cover the surrounding workflow.

## Updating

Bump the submodules to their latest upstream commits, then commit the new pointers:

```sh
git submodule update --remote
git add LemmaScript .claude/skills
git commit -m "bump submodules"
```

## License

MIT — see each submodule.
