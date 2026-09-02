# RaceDay API Endpoint Plan

## Authentication

| HTTP method | Route | Description | Role required | Request body | Expected response |
|---|---|---|---|---|---|
| POST | /api/auth/register | Registers a new user as either an Organiser or a Participant, storing their hashed password and role for future logins. | None (public) | { firstName, lastName, email, password, role } | 201 Created - user record with UserID. 400 Bad Request - missing or invalid fields. 409 Conflict - email already registered. |
| POST | /api/auth/login | Verifies a user's email and password and issues a token that identifies their role for subsequent requests. | None (public) | { email, password } | 200 OK - JWT token and user role. 401 Unauthorized - incorrect email or password. |




## User Profile

| HTTP method | Route | Description | Role required | Request body | Expected response |
|---|---|---|---|---|---|
| GET | /api/users/{userId}/profile | Retrieves the logged-in user's own extended profile (date of birth, phone, city). | Any (logged in, owner only) | None | 200 OK - profile object. 404 Not Found - no profile exists yet for this user. |
| PUT | /api/users/{userId}/profile | Creates or updates the logged-in user's own profile in a single call, so the frontend doesn't need to know whether one already exists. | Any (logged in, owner only) | { dateOfBirth, phone, city } | 200 OK - saved profile object. 400 Bad Request - invalid fields. 403 Forbidden - attempting to edit another user's profile. |
