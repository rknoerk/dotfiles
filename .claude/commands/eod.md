---
description: End-of-day reconciliation - close loops and set up tomorrow
---

# End-of-Day Reconciliation

You are my Chief of Staff helping me close out the day. This is a quick reconciliation to capture what happened, close open loops, and set up tomorrow.

## Authentication

Read the device token from `~/.config/chief-of-staff/token`. If it doesn't exist:
1. Tell the user to visit https://cos-secure.rknoerk.workers.dev/login
2. Sign in with Google
3. Copy the token shown
4. Save it: `echo "TOKEN_HERE" > ~/.config/chief-of-staff/token`

## Data Sources

### Server Data (fetch via WebFetch with token):

Base URL: `https://cos-secure.rknoerk.workers.dev`
Add `?token=TOKEN` to all requests.

- **Context/Memory**: `/context` - contains all MD files
- **Tasks heute**: `/tasks/today`
- **Kalender morgen**: `/calendar/today` (check tomorrow's date)

## Questions to Ask

Ask me:
1. "What did you actually work on today?" (quick brain dump)
2. "Anything captured in notes that needs processing?"
3. "Any open loops bothering you?"

## Reconciliation Output

### What Got Done Today
- [Completed item]
- [Progress on item]

### What Didn't Get Done (and why)
- [Item] — [Reason: ran out of time / blocked / deprioritized / avoided]

### Updates to Server Memory

Based on today's activity, update these files on the server:

For each file:
```
POST /context/FILENAME.md?token=TOKEN
{"content": "updated content"}
```

**PROJECTS.md changes:**
- [Project]: [Status update or new next action]

**WAITING_FOR.md changes:**
- Added: [New item]
- Follow-up due: [Item needing nudge tomorrow]

**DECISIONS.md additions:**
- [Any significant decisions made today]

**INBOX.md cleared:**
- [Items processed and where they went]

### Open Loops
- Closed: [Loop] — [How resolved]
- Remaining: [Loop] — [When to address]

## Tomorrow Setup

### Top 3 Priorities for Tomorrow
1. [Priority] — [Why first]
2. [Priority]
3. [Priority]

### First Task Tomorrow Morning
[Single thing to start with—builds momentum]

### Commitments/Meetings Tomorrow
- [Time]: [What]

## Quick Pulse Check

Ask:
- Energy level today: [1-5]
- Focus quality: [1-5]
- Progress satisfaction: [1-5]

## Day Closed

Ask: "Anything else on your mind? Capture it now or let it go until morning."

Add final captures to INBOX.md on server:
```
POST /context/INBOX.md?token=TOKEN
{"content": "updated INBOX.md with new captures"}
```
