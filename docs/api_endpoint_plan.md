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




## Categories

| HTTP method | Route | Description | Role required | Request body | Expected response |
|---|---|---|---|---|---|
| GET | /api/events/{eventId}/categories | Lists the age/distance categories available for a specific event (e.g. Under 20, Senior, 10km, 21km). | Any (public) | None | 200 OK - array of category objects. 404 Not Found - event does not exist. |
| POST | /api/events/{eventId}/categories | Creates a new category under a specific event, for the logged-in organiser who owns that event. | Organiser (owner of event) | { categoryName, description } | 201 Created - category record with CategoryID. 403 Forbidden - event belongs to a different organiser. 400 Bad Request - missing or invalid fields. |
| PUT | /api/categories/{categoryId} | Updates the name or description of an existing category. | Organiser (owner of parent event) | { categoryName, description } | 200 OK - updated category object. 404 Not Found - category does not exist. |
| DELETE | /api/categories/{categoryId} | Deletes a category, provided no enrolments currently reference it. | Organiser (owner of parent event) | None | 204 No Content - deleted successfully. 409 Conflict - category has existing enrolments. |




## Event Enrolments

| HTTP method | Route | Description | Role required | Request body | Expected response |
|---|---|---|---|---|---|
| GET | /api/enrollments/my | Retrieves every enrolment belonging to the logged-in participant, for their personal dashboard. | Participant | None | 200 OK - array of enrolment objects. |
| GET | /api/events/{eventId}/enrollments | Retrieves every participant enrolled in a specific event, so the organiser can manage race-day logistics. | Organiser (owner of event) | None | 200 OK - array of enrolment objects. 403 Forbidden - event belongs to a different organiser. |
| POST | /api/enrollments | Enrols the logged-in participant into an event by selecting one of its categories, recording the link between Participant, Event, and Category. | Participant | { eventId, categoryId } | 201 Created - enrolment record with EnrollmentID. 400 Bad Request - categoryId does not belong to the given event. 404 Not Found - event or category does not exist. 409 Conflict - participant already enrolled in this event. |
| PUT | /api/enrollments/{enrollmentId}/status | Updates the status of an enrolment, for example to cancel it. | Participant (owner) | { status } | 200 OK - updated enrolment object. 404 Not Found - enrolment does not exist. |
