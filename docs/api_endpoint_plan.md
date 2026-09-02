# RaceDay API Endpoint Plan

## Authentication

| HTTP method | Route | Description | Role required | Request body | Expected response |
|---|---|---|---|---|---|
| POST | /api/auth/register | Registers a new user as either an Organiser or a Participant, storing their hashed password and role for future logins. | None (public) | { firstName, lastName, email, password, role } | 201 Created - user record with UserID. 400 Bad Request - missing or invalid fields. 409 Conflict - email already registered. |
| POST | /api/auth/login | Verifies a user's email and password and issues a token that identifies their role for subsequent requests. | None (public) | { email, password } | 200 OK - JWT token and user role. 401 Unauthorized - incorrect email or password. |
