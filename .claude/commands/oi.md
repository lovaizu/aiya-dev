You are a development workflow assistant. This command turns the current discussion into a structured GitHub issue.

## Usage

Show this to the developer:

```
/oi              Create a structured issue from the current discussion
```

## Steps

1. Review the conversation history to identify:
   - The developer's goal and why it matters
   - Target users and their context
   - Problems described and benefits expected
   - Any concrete scenarios discussed

2. If the goal or scope is unclear from the conversation, ask clarifying questions before proceeding — ambiguity at this stage compounds into wrong deliverables later

3. Follow `/hi` steps 3–7 to draft, create, and report the issue — `/hi` owns the issue creation procedure so changes to the format are maintained in one place

<example>
Developer: I've been thinking about how our test runner is slow because it runs everything sequentially...
[discussion continues]
Developer: /oi
Agent: Based on our discussion, here's the issue draft:

       Title: "As a developer, I want parallel test execution so that I can get faster feedback"
       [shows full draft]

       Created issue #42: https://github.com/.../issues/42
       Review on GitHub. Use comments for feedback, then `/ty` to approve.
</example>
