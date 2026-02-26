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

3. Draft the issue following `requirements-definition.md` (Draft section) and `issue-format.md`:
   - Write the Situation section from facts discussed in the conversation
   - Write the Pain table — derive each pain from the Situation
   - Write the Benefit table — link each benefit to a Pain
   - Write the Acceptance Scenarios tables — group by target user, link each to a Benefit
   - Write the title in user story format: "As a [role], I want [goal] so that [benefit]"

4. Verify the draft (see `requirements-definition.md` Verify section):
   - Every Pain arises from a fact in the Situation
   - Every Benefit traces to a Pain (Pain column filled)
   - Every Benefit uses "[who] can [what]" form
   - Every AS traces to a Benefit (Benefit column filled)
   - AS are grouped under headings matching [who] from their Benefits
   - Title [benefit] summarizes the primary Benefit
   - Each AS has concrete, observable Given-When-Then

5. If any check fails, revise and re-verify

6. Show the verified draft to the developer — display the title and full body so they can see what will be created

7. Create the issue on GitHub: `gh issue create`
   - If `gh issue create` fails, tell the developer and suggest checking `gh auth status` and repo permissions

8. Tell the developer the issue URL and say: "Review on GitHub. Use comments for feedback, then `/ty` to approve."

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
