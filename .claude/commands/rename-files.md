# File Rename

**Version:** 2.2 - 2025-12-26

I have a folder of messy files that I will provide to you. I want them renamed and organized.

## PHASE 1: ANALYZE (no user input needed)

Scan ALL files in the folder. For each file:
1. Skip system files (.DS_Store, .localized, desktop.ini)
2. Auto-flag for deletion: temp files (~$*), exact duplicates (filename with " (1)", " (2)" etc. that have identical content)
3. Read contents where possible to identify type: receipt, statement, or project

**Naming convention for type receipt:**
`YYYY-MM-DD [Vendor] [Was] [Betrag].ext`

**Naming convention for type statement:**
`YYYY-MM-DD [Financial Institution] [Month].ext` (if monthly)
`YYYY-MM-DD [Financial Institution] [Quarter].ext` (if quarterly)
`YYYY-MM-DD [Financial Institution] [Keyword].ext` (for anything that's not monthly/quarterly)

**Naming convention for type project:**
`YYYY-MM-DD [Project] [Topic] [Keyword] [Version].ext` (keyword and version are optional)
`YYYY [Project] [Topic] [Keyword] [Version].ext` if date is not explicit (keyword and version are optional)

Components:
1. **Date** (YYYY-MM-DD): Receipt/invoice date, statement date, document date if explicit
2. **Year** (YYYY): document date if year is not explicit
3. **Vendor**: Who was paid (short, consistent: Amazon, REWE, DHL, etc.)
4. **Financial Institution**: Name of the bank that issued the statement (abbreviate, consistent: SPK GM, SPK H, Schwab, BBVA, BofA, etc.)
5. **Month** (MM): Month of the transaction within the statement
6. **Quarter** (Qn): Quarter of the transactions within the statement (e.g. Q1, Q2, Q3, Q4)
7. **Was**: Brief description (Büromaterial, Fahrtkosten, Software, Catering)
8. **Betrag** (optional): Amount for quick scanning (12,50 or 149,00)
9. **Project**: Project name, short and consistent for easy reference (e.g. Spur, Blackbird, Setkit, Quickbooks)
10. **Topic**: Thema, Anlass, Lieferant
11. **Keyword**: inhaltliches Stichwort
12. **Version**: Version if provided or `_signed` for documents that require signatures

Separators: Spaces for readability.

**Examples:**
- `2024-03-15 Amazon USB-Kabel 12,99.pdf`
- `2024-03-20 REWE Catering Dreh 89,50.pdf`
- `2024-04-01 Adobe CreativeCloud Abo.pdf`
- `2022-12-02 DKB 12.pdf`
- `2022-12-30 DKB Jahresabschluss.pdf`
- `2025-12-24 Blackbird CO2-Bilanz Final.pdf`
- `2025-12-24 Blackbird Green-Motion Abschlussbericht_signed.pdf`

**Your task for each file:**
1. Identify type of document: receipt, statement, project
2. Extract from each file depending on document type:
   - receipt: date, vendor, description, amount
   - statement: date, financial institution, month or quarter or keyword
   - project: date or year, project name, topic, keyword, version
3. Propose new filename
4. Suggest subfolder by Vendor, Project, or Financial Institution

## PHASE 2: PRESENT COMPLETE PLAN

Present ONE summary table with ALL files:

| # | Current Name | Type | Action | Proposed Name | Subfolder | Confidence |

Actions: 
- RENAME — file needs renaming
- DELETE (duplicate) — exact duplicate of another file
- DELETE (temp) — temporary file (~$*)
- SKIP — already follows naming convention, move to subfolder only

Flag any files where date/vendor/institution/project couldn't be extracted with ⚠️.

Show summary:
- Total files to rename
- Total duplicates to delete  
- Total temp files to delete
- Total files to skip (already correct)
- Subfolders to create

Ask ONCE: "Proceed with all changes? (yes / no / review [numbers])"

## PHASE 3: EXECUTE (after single approval)

If "yes": Execute all changes, log results.
If "review [numbers]": Show details for those specific files, then ask again.
If "no": Abort.

STOP if any overwrite would occur.

## OUTPUT

Final summary with:
- Files renamed (count)
- Files deleted (count)
- Folders created (list)
- Any errors encountered