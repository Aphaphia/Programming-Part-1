# Programming-Part-1
# RaceDay

RaceDay is a full-stack web-based event management system built for the South African road running, walking, and cycling community. Event Organisers can create and manage events, categories, and participant results, while Participants can browse events, enter events by category, and track their personal performance history.

This is an individual Portfolio of Evidence (PoE) project built progressively across three parts:
- **Part 1:** System planning (ERD, API endpoint plan, SQL script)
- **Part 2:** REST API implementation
- **Part 3:** MVC frontend implementation

## User Roles

**Organiser** — can create, edit, and delete events, manage event categories, capture participant results, and view all event enrolments.

**Participant** — can create an account, browse events, enter an event by selecting a category, view their own enrolments, and track their personal results.

## Tech Stack
- Backend: ASP.NET Core Web API (C#)
- Database: SQL Server / T-SQL
- Frontend: ASP.NET Core MVC

## Project Planning (Part 1)
All planning documents are in the `/docs` folder:
- `raceday_erd.pdf` — Entity Relationship Diagram (Section A)
- `api_endpoint_plan.md` — Full API endpoint plan (Section B)
- `schema.sql` — SQL Server script with schema and seed data (Section C)

## CI/CD

A GitHub Actions workflow validates that the `/docs` folder exists and contains the required planning files on every push.
docs/Screenshot 2026-09-04 030756.png


## Video Walkthrough

_(Unlisted YouTube link to be added here — walkthrough of planning documents, ERD decisions, endpoint plan choices, and the SQL script running live in SSMS.)_

## Setup Instructions
_(To be completed in Part 2 once the API project is added.)_
