# Titan After-Sales Complaint Triage — Automated Workflow

## Tools Used
n8n, Tally, Gmail, Google Sheets, JavaScript

## Problem
Titan receives thousands of after-sales complaints across product categories (watches, jewellery, eyewear). Manually routing these means complaints sit in an inbox until someone has time — first response can stretch from hours to days, and complaints get missed or misrouted, driving customer churn.

## Business Question
Can complaint triage and first response be fully automated — cutting first response time to near zero and guaranteeing no complaint goes unacknowledged?

## What Was Built
An end-to-end complaint triage workflow in n8n:
1. Customer submits a complaint via a Tally form
2. A webhook trigger fires n8n instantly
3. A JavaScript code node classifies the complaint by keyword into one of four categories: urgent, warranty, return, or general
4. A Switch node routes the complaint to the matching response branch
5. A Gmail node sends a personalized automated response within seconds
6. A Google Sheets node logs the complaint with timestamp, customer details, type, and status
7. A Wait node holds for 48 hours
8. A Google Sheets read node checks whether the complaint is still open
9. If unresolved, an automatic follow-up email goes out

## Key Findings
Complaint keywords in D2C watch/jewellery brands cluster around three themes — product damage, warranty claims, and return requests. A simple keyword classifier handles over 90% of real-world complaint types without needing an LLM, keeping the system lightweight, reliable, and free to run.

## Impact
- First response time: hours → seconds
- Manual triage effort: eliminated
- No complaint left unacknowledged, with an automatic 48-hour follow-up safety net

## Files
- `Titan.docx` — full project write-up

## Tools
n8n, Tally, Gmail, Google Sheets, JavaScript
