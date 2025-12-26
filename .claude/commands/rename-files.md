# File Rename

**Version:** 2.0 - 2025-12-26

I have a folder of messy files that I will provide to you. I want them renamed and organized.

## PHASE 1: ANALYZE (no user input needed)

Scan ALL files in the folder. For each file:
1. Skip system files (.DS_Store, .localized, desktop.ini)
2. Auto-flag for deletion: temp files (~$*), exact duplicates (filename with " (1)", " (2)" etc. that have identical content)
3. Read contents where possible to identify type: receipt, statement, or project

**Naming conventions:**

Receipts: `YYYY-MM-DD [Vendor] [Was] [Betrag].ext`
Statements: `YYYY-MM-DD [Institution] [Month/Quarter/Keyword].ext`
Projects: `YYYY-MM-DD [Project] [Topic] [Keyword] [Version].ext` or `YYYY [Project] [Topic].ext` if no exact date

Components:
- **Date** (YYYY-MM-DD): From document content
- **Vendor**: Short, consistent (Amazon, REWE, DHL)
- **Institution**: Abbreviated (SPK GM, DKB, BofA, Schwab)
- **Betrag**: Optional amount (12,50 or 149,00)
- **Project**: Short name (Spur, Blackbird, Setkit)
- **Version**: If provided, or `_signed` for signed documents

Separators: Spaces

## PHASE 2: PRESENT COMPLETE PLAN

Present ONE summary table with ALL files:

| # | Current Name | Action | Proposed Name | Subfolder | Confidence |

Actions: RENAME, DELETE (duplicate), DELETE (temp), SKIP (already correct)

Flag any files where extraction failed with ⚠️.

Show summary:
- Total files to rename
- Total duplicates to delete
- Total temp files to delete
- Subfolders to create

Ask ONCE: "Proceed with all changes? (yes / no / review [numbers])"

## PHASE 3: EXECUTE (after single approval)

If "yes": Execute all changes, log results.
If "review [numbers]": Show details for those files, then ask again.
If "no": Abort.

STOP if any overwrite would occur.

## OUTPUT

Final summary with:
- Files renamed
- Files deleted
- Folders created
- Any errors
