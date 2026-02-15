# skill-creator (full version)

## Background

Anthropic provides a skill called `skill-creator` that helps build, test, and improve Claude Code skills. There are two versions:

- **Minimal version** — Published on GitHub at [anthropics/skills](https://github.com/anthropics/skills). Covers skill creation guidance, static validation, and packaging.
- **Full version** — Includes everything in the minimal version, plus eval mode (execute a skill and grade against expectations), benchmark mode (compare with/without a skill), and four specialized agents (executor, grader, comparator, analyzer).

As of February 2025, the full version is not available through Claude Code's skill install feature or on the public GitHub repository. It can only be obtained by asking Claude to provide the files directly.

## Why this copy exists

We extracted the full version from a zip provided by Claude and placed it here so that skill developers in this repository can use eval and benchmark modes without manual setup each time.

## When to replace

When Anthropic publishes the full version of skill-creator on GitHub (likely at [anthropics/skills](https://github.com/anthropics/skills)), replace this directory with the official release. The official version will receive updates and bug fixes that this snapshot will not.

## License

Apache License 2.0 — see [LICENSE.txt](LICENSE.txt).
