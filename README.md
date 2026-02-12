# ciya-dev
Claude Code in your area

## Getting Started

### 1. Clone (first time)

```bash
curl -fsSL https://raw.githubusercontent.com/lovaizu/ciya-dev/main/scripts/up.sh | bash
```

### 2. Set up environment

```bash
cd ciya-dev/main
cp .env.example .env
vi .env
```

`hi.sh` automatically sources `.env` from the worktree directory on startup.

### 3. Start or resume a task

```bash
cd ciya-dev
./main/scripts/hi.sh <branch-name>
```

For a new branch, this creates a worktree. For an existing branch, it enters the worktree. Then starts Claude Code.

### 4. Work

| Command | When to use |
|---------|-------------|
| `/hi`   | Start new work — describe your goal and create an Issue |
| `/go`   | Resume work — pick up where you left off |
| `/fb`   | Address feedback comments on Issues or PRs |
| `/ty`   | Approve the current gate and move forward |

### 5. Clean up

After merging, remove the worktree:

```bash
cd ciya-dev
./main/scripts/bb.sh <branch-name-or-path>
```

Verifies Issue/PR completion before cleanup. Cleans up the worktree, local branch, and remote branch.

## Workflow

```
 hi.sh branch-name          Create worktree and launch Claude
       │
       ▼
 ╔═══════════════════════════════════════════════════╗
 ║  /hi  or  /go                                    ║
 ╠═══════════════════════════════════════════════════╣
 ║                                                   ║
 ║  1. Hearing              Describe your goal       ║
 ║  2. Issue creation ────── Issue appears on GitHub  ║
 ║                                                   ║
 ║  ┌───────────────────────────────────────────┐    ║
 ║  │ Gate 1: Goal approval                     │    ║
 ║  │ Review Issue on GitHub · /fb · /ty        │    ║
 ║  └───────────────────────────────────────────┘    ║
 ║                                                   ║
 ║  3. PR description ────── PR appears on GitHub    ║
 ║                                                   ║
 ║  ┌───────────────────────────────────────────┐    ║
 ║  │ Gate 2: Approach approval                 │    ║
 ║  │ Review PR on GitHub · /fb · /ty           │    ║
 ║  └───────────────────────────────────────────┘    ║
 ║                                                   ║
 ║  4. Implementation                                ║
 ║  5. Consistency check                             ║
 ║  6. Expert review                                 ║
 ║  7. SC check                                      ║
 ║                                                   ║
 ║  ┌───────────────────────────────────────────┐    ║
 ║  │ Gate 3: Goal verification                 │    ║
 ║  │ Review code on GitHub · /fb · /ty         │    ║
 ║  └───────────────────────────────────────────┘    ║
 ║                                                   ║
 ║  8. Merge                                         ║
 ╚═══════════════════════════════════════════════════╝
       │
       ▼
 bb.sh branch-name          Clean up worktree and branches
```

**Three gates require your approval:**

| Gate | What you review | Where |
|------|----------------|-------|
| Goal approval | Issue (Situation, Pain, Benefit, Success Criteria) | GitHub Issue page |
| Approach approval | PR description (Approach, Tasks) | GitHub PR page |
| Goal verification | Implementation and test results | GitHub PR page |

At each gate: review on GitHub, leave comments if needed (`/fb` to address them), then `/ty` to approve.
