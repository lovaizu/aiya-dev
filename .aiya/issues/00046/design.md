## Problem Summary

aiya-dev has 6 short-named commands/scripts (`wc.sh`, `up.sh`, `/hi`, `/bb`, `/fb`, `/ty`) that form a conversational flow (Welcome → Up → Hi → Bye-bye → Feedback → Thank you), but this isn't documented. New users can't guess what the abbreviations stand for.

## Approach

Add a "Full Name" column to the README Commands table so users can see the origin of each abbreviation at a glance. Also include `wc.sh` and `up.sh` in the table since they are part of the same naming convention.

## Key Decisions

- Add a column to the existing table rather than creating a separate section, keeping the information co-located with the command reference
- Include scripts (`wc.sh`, `up.sh`) in the Commands table alongside slash commands, since they share the same naming convention

## Open Questions

None.
