# File Rename

**Version:** 1.01 - 2025-12-24

I have a folder of messy files in a folder that I will provide to you. I want them renamed and organized.

TASK: Process these in batches of 5 with checkpoints for my review.

## PHASE 1: ANALYZE

Look at all the files in this folder. For any files that look messy/do not already follow the naming conventions below, read the contents where possible. Identify if the document is a receipt, statement, or something project-related.

**Naming convention for receipts:**
'YYYY-MM-DD [Vendor] [Was] [Betrag].ext'

**Naming convention for statements:**
'YYYY-MM-DD [Financial Institution] [Month].ext' (if monthly)
'YYYY-MM-DD [Financial Institution] [Quarter].ext' (if quarterly)
'YYYY-MM-DD [Financial Institution] [Keyword].ext' (for anything that's not monthly/quarterly)

**Naming convention for project-related files:**
'YYYY-MM-DD [Project] [Topic] [Keyword] [Version].ext' (keyword and version are optional)
'YYYY Project [Topic] [Keyword] [Version].ext' if date is not explicit (keyword and version are optional)

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
12. **Version**: Version if provided or '_signed' for documents that require signatures

Separators: Spaces for readability.

**Examples:**
- '2024-03-15 Amazon USB-Kabel 12,99.pdf'
- '2024-03-20 REWE Catering Dreh 89,50.pdf'
- '2024-04-01 Adobe CreativeCloud Abo.pdf'
- '2022-12-02 DKB 12.pdf'
- '2022-12-30 DKB Jahresabschluss.pdf'

**Your task:**
1. Identify type of document: receipt, statement, project
2. Extract from each file depending on document type:
   - receipt date, vendor, description
   - statement date, financial institution, month or quarter
   - project date or year, project name, topic, keyword, version
3. Propose new filename
4. Suggest subfolder by Vendor, Project OR by month (YYYY-MM)

Present as tables:

| Current Name | Date | Proposed Name | Subfolder | Confidence |

Flag files where date/vendor/financial institution/project couldn't be extracted.

DO NOT rename yet.

---

## PHASE 2: EXECUTE (after my approval)

Rename files, create subfolders, log all changes.

STOP if any overwrite would occur.
