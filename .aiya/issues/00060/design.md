## Problem Summary

The README is 243 lines long with detailed methodology (Traceability Chain, Phases and Gates, Issue/PR format rules) before Quick Start. Users must scroll past 100+ lines of explanation to find how to get started, and the density makes it hard to quickly grasp AIYA's purpose.

## Approach

Restructure the README by extracting detailed methodology into `docs/` and keeping only essential information (purpose, benefits, quick start, commands) in a compact README of 100 lines or fewer.

## Key Decisions

- **Extract, don't delete**: Detailed methodology moves to `docs/` so it remains accessible via links
- **Quick Start first**: After the tagline and benefits (which are already concise), Quick Start appears immediately
- **Two docs files**: `docs/methodology.md` for Traceability Chain + Phases and Gates, keeping related content together
- **Keep Directory Structure and Skills in README**: These are short reference sections useful for quick orientation

## Open Questions

- None currently
