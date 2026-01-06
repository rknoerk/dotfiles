---
description: Create a detailed task spec for delegation to a sub-agent
argument-hint: <optional: task description>
---

# Sub-Agent Task Specification

You are helping me create a task specification detailed enough for an autonomous agent to execute without further input from me. The goal is maximum clarity and minimum ambiguity.

If you don't have enough information, ask me questions until you do.

## If No Argument Provided

Ask: "What task do you want to delegate? Describe what you want done—can be rough, I'll help you refine it."

## Specification Output

### 1. Objective
**What:** [One sentence—what does done look like?]
**Why:** [Why this matters—context for decision-making during execution]

### 2. Success Criteria
The task is complete when:
- [ ] [Specific, verifiable criterion]
- [ ] [Another criterion]
- [ ] [Another criterion]

### 3. Scope Boundaries
**In scope:**
- [Thing that's included]

**Out of scope:**
- [Thing to explicitly NOT do]
- [Edge case to ignore]

### 4. Inputs Provided
- [Document/data/context the agent has access to]

### 5. Constraints
**Time:** [Deadline or time budget]
**Tone/Style:** [If relevant—formal, casual, technical, etc.]
**Tools:** [What the agent can use]
**Permissions:** [What the agent can and cannot do]

### 6. Dependencies
**Blocked by:** [Things that must happen first]
**Blocks:** [Things waiting on this]
**People involved:** [Who might need to be consulted or informed]

### 7. Decision Framework
When the agent encounters ambiguity:
1. **If [situation]** → [do this]
2. **If [other situation]** → [do that]
3. **If unclear** → [stop and ask / make best judgment / flag for review]

### 8. Reversibility Assessment
**Can this be undone?** [Yes easily / Yes with effort / No]
**What could go wrong?** [Worst case scenario]
**Mitigation:** [How to catch problems early]

### 9. Output Format
The deliverable should be:
- **Format:** [Doc / Email draft / Spreadsheet / Code / etc.]
- **Length:** [Approximate]
- **Structure:** [Sections or components to include]
- **Deliver to:** [Where should the output go]

### 10. Verification
Before considering this complete, the agent should:
- [ ] [Self-check 1]
- [ ] [Self-check 2]
- [ ] [Review against success criteria]

## Questions Before Starting

[Space for clarifying questions before execution]

## After Creating Spec

Save the task spec to: `~/chief-of-staff/work-orders/[task-name].md`

Offer to also add a tracking entry to `~/chief-of-staff/WAITING_FOR.md` if this is being delegated to another agent or person.
