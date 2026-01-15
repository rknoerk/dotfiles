# Staffing Schedule Automation Plan

## Problem Statement

A GM spends significant time manually creating weekly staffing schedules with:
- **Variable employee availability** (changes each week)
- **Variable staffing needs** (fluctuates with business volume)
- **Current tool**: When I Work (scheduling software)

**Goal**: Automate schedule generation so the GM reviews/approves rather than builds from scratch.

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────┐
│                        DATA INPUTS                                   │
├──────────────────┬──────────────────┬───────────────────────────────┤
│  Employee Data   │  Business Data   │  Constraints/Rules            │
│  - Availability  │  - Volume fcst   │  - Min/max hours              │
│  - Skills/roles  │  - Historical    │  - Overtime rules             │
│  - Preferences   │  - Events        │  - Break requirements         │
│  - Max hours     │  - Seasonality   │  - Role coverage              │
└────────┬─────────┴────────┬─────────┴──────────────┬────────────────┘
         │                  │                        │
         ▼                  ▼                        ▼
┌─────────────────────────────────────────────────────────────────────┐
│                   SCHEDULING ENGINE                                  │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐                  │
│  │ Constraint  │→ │ Optimization│→ │  Conflict   │                  │
│  │ Validation  │  │  Algorithm  │  │  Detection  │                  │
│  └─────────────┘  └─────────────┘  └─────────────┘                  │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────────┐
│                      OUTPUT & REVIEW                                 │
│  - Draft schedule with coverage visualization                        │
│  - Conflict/gap alerts                                               │
│  - Optimization suggestions                                          │
│  - GM approval workflow                                              │
└────────────────────────────┬────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────────┐
│                   WHEN I WORK INTEGRATION                            │
│  - Export availability → Process → Import schedule                   │
│  - OR: Full API integration (OAuth 2.0)                             │
└─────────────────────────────────────────────────────────────────────┘
```

---

## Implementation Phases

### Phase 1: Manual Input / LLM-Assisted (Start Here)

**Approach**: GM provides data, Claude generates schedule

**Workflow**:
1. GM exports availability from When I Work (CSV/screenshot)
2. GM provides staffing requirements for the week
3. Claude generates optimized schedule
4. GM reviews, adjusts, manually enters into When I Work

**Skill**: `/staffing` command

**Data Format** (GM provides or maintains in a file):
```yaml
# STAFFING_CONFIG.md

## Employees
| Name     | Roles          | Max Hrs | Preferences           |
|----------|----------------|---------|------------------------|
| Alice    | cashier, stock | 40      | prefers morning        |
| Bob      | cashier, lead  | 32      | no Sundays             |
| Carol    | stock, receive | 40      | flexible               |

## Shift Templates
| Shift    | Time        | Roles Needed              | Min Staff |
|----------|-------------|---------------------------|-----------|
| Open     | 6am-2pm     | 1 lead, 2 cashier, 1 stock| 4         |
| Mid      | 10am-6pm    | 1 cashier, 1 stock        | 2         |
| Close    | 2pm-10pm    | 1 lead, 2 cashier, 1 stock| 4         |

## Business Rules
- No more than 6 consecutive days
- 8 hours minimum between shifts
- Overtime after 40 hrs/week
- Leads must be present at open/close
```

**Benefits**:
- Zero integration complexity
- Works immediately
- Learns business patterns through iteration

---

### Phase 2: Structured Data + Persistence

**Approach**: Add backend storage for staffing data

**Components**:
1. **Cloudflare Worker endpoints** (extend existing COS backend):
   - `GET /staffing/employees` - Employee roster with roles/constraints
   - `GET /staffing/availability/:week` - Weekly availability submissions
   - `GET /staffing/requirements/:week` - Staffing needs for the week
   - `POST /staffing/schedule/:week` - Save generated schedule
   - `GET /staffing/history` - Past schedules for pattern analysis

2. **Data persistence**: D1 database or KV storage

3. **Availability collection**: Simple form for employees to submit weekly availability

**Benefits**:
- Persistent employee data (don't re-enter each week)
- Historical patterns for optimization
- Foundation for full automation

---

### Phase 3: When I Work API Integration

**Approach**: Direct integration with When I Work API

**When I Work API Capabilities**:
- OAuth 2.0 authentication
- REST endpoints for:
  - `/users` - Employee data
  - `/shifts` - Create/read/update shifts
  - `/availabilities` - Employee availability
  - `/schedules` - Full schedule management
  - `/positions` - Job roles/positions

**Integration Flow**:
```
1. Authenticate with When I Work (OAuth token)
2. Pull employee availability (GET /availabilities)
3. Pull staffing templates (GET /positions, historical shifts)
4. Generate optimized schedule (LLM + algorithm)
5. Present to GM for approval
6. Push approved schedule (POST /shifts)
```

**Benefits**:
- No manual data entry
- Real-time availability sync
- Direct schedule publishing

---

### Phase 4: Predictive Staffing

**Approach**: Use historical data to predict staffing needs

**Components**:
1. **Volume forecasting**:
   - Historical sales/traffic patterns
   - Day-of-week trends
   - Seasonal adjustments
   - Event calendar integration

2. **Dynamic requirements**:
   - Auto-adjust min staff based on predicted volume
   - Flag unusual periods (holidays, events)
   - Suggest additional coverage proactively

3. **Pattern learning**:
   - Track schedule changes GM makes
   - Learn preferences not explicitly stated
   - Improve suggestions over time

---

## Scheduling Algorithm

The core scheduling problem is a **constraint satisfaction + optimization** problem.

### Hard Constraints (Must Satisfy)
- Employee only scheduled when available
- Role requirements met (enough cashiers, leads, etc.)
- Max hours not exceeded
- Legal requirements (breaks, rest between shifts)
- No double-booking

### Soft Constraints (Optimize For)
- Employee preferences honored when possible
- Fair distribution of desirable/undesirable shifts
- Minimize overtime costs
- Consistent schedules week-to-week when desired
- Seniority preferences

### Algorithm Approach

**Option A: LLM Reasoning (Simpler, Good for Small Teams)**
```
Prompt: Given availability matrix and requirements,
generate schedule satisfying constraints and optimizing for fairness.
Output as structured table.
```
- Works well for ~10-20 employees
- Handles nuance and edge cases naturally
- GM can "negotiate" adjustments conversationally

**Option B: Hybrid (LLM + Algorithmic)**
```
1. Use constraint solver to find valid assignments
2. Use LLM to rank/select among valid options
3. Use LLM to explain tradeoffs to GM
```
- Better for larger teams (20+ employees)
- More consistent optimization
- LLM adds human-readable explanations

**Option C: Full Optimization (Complex)**
```
1. Model as integer linear program (ILP)
2. Solve with OR-Tools or similar
3. Present optimal solution to GM
```
- Best for large teams (50+ employees)
- Requires more engineering
- May be overkill for typical retail

**Recommendation**: Start with Option A for simplicity, evolve to B if needed.

---

## Skill Design: `/staffing`

### Modes

```
/staffing              → Main menu (like /cos)
/staffing setup        → Configure employees, shifts, rules
/staffing plan <week>  → Generate schedule for specified week
/staffing check        → Validate current draft, find gaps
/staffing optimize     → Suggest improvements to existing schedule
/staffing export       → Format for When I Work import
```

### Example Interaction

```
User: /staffing plan next-week

Claude: Let me generate the schedule for next week (Jan 20-26).

First, I'll gather the inputs:
✓ 8 employees with availability submitted
✓ Standard shift templates loaded
✓ Business volume: Expected normal (no events flagged)

Generating schedule...

## Draft Schedule: Jan 20-26

| Day      | Open (6a-2p)         | Mid (10a-6p)    | Close (2p-10p)        |
|----------|----------------------|-----------------|------------------------|
| Mon      | Alice (L), Bob, Carol| Dana            | Eve (L), Frank, Grace  |
| Tue      | Alice (L), Bob, Dana | Carol           | Eve (L), Frank, Grace  |
| ...

## Coverage Analysis
✓ All shifts covered with required roles
✓ No overtime triggered
⚠ Frank at 38 hrs (close to limit)
⚠ Carol has 3 closes in a row (preference conflict)

## Suggestions
1. Swap Carol's Wed close with Dana's Wed mid to honor Carol's "no 3 closes" preference
2. Consider adding 2 hrs to Grace to give Frank buffer

Would you like me to:
1. Apply suggestion #1
2. Apply both suggestions
3. Show alternative schedules
4. Export as-is
```

---

## Data Model

### Employee
```json
{
  "id": "emp_001",
  "name": "Alice Smith",
  "roles": ["cashier", "lead"],
  "maxHoursPerWeek": 40,
  "preferences": {
    "preferredShifts": ["open"],
    "avoidShifts": ["close"],
    "unavailableDays": [],
    "maxConsecutiveDays": 5
  },
  "skills": ["register", "inventory", "training"],
  "seniority": "2023-06-15",
  "hourlyRate": 18.50
}
```

### Availability (Weekly)
```json
{
  "employeeId": "emp_001",
  "weekOf": "2026-01-20",
  "availability": {
    "Mon": {"available": true, "times": "6am-10pm"},
    "Tue": {"available": true, "times": "6am-6pm"},
    "Wed": {"available": false},
    "Thu": {"available": true, "times": "10am-10pm"},
    "Fri": {"available": true, "times": "any"},
    "Sat": {"available": true, "times": "any"},
    "Sun": {"available": false}
  }
}
```

### Shift Template
```json
{
  "name": "Open",
  "startTime": "06:00",
  "endTime": "14:00",
  "requiredRoles": [
    {"role": "lead", "count": 1},
    {"role": "cashier", "count": 2},
    {"role": "stock", "count": 1}
  ],
  "minStaff": 4,
  "maxStaff": 6
}
```

### Business Requirements (Weekly)
```json
{
  "weekOf": "2026-01-20",
  "adjustments": {
    "Sat": {"multiplier": 1.5, "reason": "Expected busy - local event"},
    "Mon": {"multiplier": 0.8, "reason": "Holiday - reduced hours"}
  },
  "notes": "Store closes at 6pm Monday for MLK Day"
}
```

---

## When I Work API Reference

**Base URL**: `https://api.wheniwork.com/2`

**Key Endpoints**:
| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/login` | POST | Authenticate, get token |
| `/users` | GET | List employees |
| `/positions` | GET | List job roles |
| `/availabilities` | GET | Get availability by date range |
| `/shifts` | GET/POST | Read/create shifts |
| `/schedules` | GET | Get schedule by date range |

**Authentication**:
```
POST /login
{
  "email": "gm@business.com",
  "password": "..."
}
→ Returns token for subsequent requests
```

**Create Shift**:
```
POST /shifts
{
  "user_id": 12345,
  "position_id": 67,
  "start_time": "2026-01-20 06:00:00",
  "end_time": "2026-01-20 14:00:00"
}
```

---

## Recommended Starting Point

For immediate value with minimal complexity:

1. **Create `/staffing` skill** in `.claude/commands/staffing.md`
2. **Use manual input format** (GM pastes availability, requirements)
3. **LLM generates schedule** with conflict detection
4. **GM manually enters** into When I Work

This proves the concept and delivers value immediately. Then iterate toward API integration based on actual usage patterns.

---

## Success Metrics

- **Time saved**: Reduce schedule creation from hours to minutes
- **Coverage quality**: Zero uncovered shifts in published schedules
- **Employee satisfaction**: Preferences honored more consistently
- **Overtime reduction**: Better optimization reduces unplanned overtime
- **GM approval rate**: Percentage of drafts accepted with minimal changes

---

## Next Steps

1. [ ] Create basic `/staffing` skill with manual input
2. [ ] Define standard data format for availability/requirements
3. [ ] Build prompt engineering for schedule generation
4. [ ] Test with sample data
5. [ ] Iterate based on GM feedback
6. [ ] Consider When I Work API integration (Phase 3)
