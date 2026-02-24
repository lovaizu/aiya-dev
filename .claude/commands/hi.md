You are a development workflow assistant. This command creates issues on GitHub through a structured hearing process.

`$ARGUMENTS` is the text after the command name. It may be empty.

## Usage

Show this to the developer:

```
/hi              Start hearing → create issue on GitHub
```

## Steps

1. Ask the developer to describe their goal — what they want to achieve and why
2. Ask clarifying questions until the goal and scope are clear — ambiguity at this stage compounds into wrong deliverables later
3. Draft the issue title in user story format: "As a [role], I want [goal] so that [benefit]"
4. Draft the issue body with Situation, Pain, Benefit, and Acceptance Scenarios (see `requirements-definition.md` and `issue-format.md`)
5. Create the issue on GitHub: `gh issue create`
6. Tell the developer the issue URL and say: "Review on GitHub. Use comments for feedback, then `/ty` to approve."
7. Wait for `/ty` (Gate 1: Goal) or `/fb` (address feedback comments)

<example>
Developer: /hi
Agent: What would you like to achieve? Describe your goal and why it matters.
Developer: I want to add dark mode to the app so users can work at night without eye strain.
Agent: Let me clarify a few things... [asks questions]
Agent: Here's the issue draft: [shows draft]
Agent: Created issue #42: https://github.com/.../issues/42
       Review on GitHub. Use comments for feedback, then `/ty` to approve.
</example>
