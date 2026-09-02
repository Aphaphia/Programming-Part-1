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




## Events

| HTTP method | Route | Description | Role required | Request body | Expected response |
|---|---|---|---|---|---|
| GET | /api/events | Lists all events so both roles can browse what's available, including each event's name, date, location, distance, and type. | Any (public) | None | 200 OK - array of event objects. |
| GET | /api/events/{eventId} | Retrieves the full detail of a single event. | Any (public) | None | 200 OK - event object. 404 Not Found - event does not exist. |
| POST | /api/events | Creates a new event under the logged-in organiser's account. | Organiser | { eventName, description, eventDate, location, distance, eventType } | 201 Created - event record with EventID. 400 Bad Request - missing or invalid fields (e.g. eventType not one of run/walk/cycle). |
| PUT | /api/events/{eventId} | Updates the details of an event that belongs to the logged-in organiser. | Organiser (owner) | { eventName, description, eventDate, location, distance, eventType } | 200 OK - updated event object. 403 Forbidden - event belongs to a different organiser. 404 Not Found - event does not exist. |
| DELETE | /api/events/{eventId} | Deletes an event belonging to the logged-in organiser, provided it has no active enrolments. | Organiser (owner) | None | 204 No Content - deleted successfully. 403 Forbidden - event belongs to a different organiser. 409 Conflict - event has active enrolments. |
