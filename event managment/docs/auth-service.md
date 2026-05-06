# Auth Service API

Base URL: /api/auth

## Error Response Format

{
  "timestamp": "2026-05-06T12:00:00.000+00:00",
  "status": 400,
  "error": "Bad Request",
  "message": "Error description",
  "path": "/api/auth/register"
}

## Register

POST /api/auth/register

Request

{
  "name": "Ali",
  "email": "ali@test.com",
  "password": "123456",
  "role": "ATTENDEE"
}

Responses

201 Created
{
  "token": "JWT_TOKEN"
}

400 Bad Request
{
  "timestamp": "2026-05-06T12:00:00.000+00:00",
  "status": 400,
  "error": "Bad Request",
  "message": "name: must not be blank",
  "path": "/api/auth/register"
}

409 Conflict (email already registered)
{
  "timestamp": "2026-05-06T12:00:00.000+00:00",
  "status": 409,
  "error": "Conflict",
  "message": "Email is already registered.",
  "path": "/api/auth/register"
}

## Login

POST /api/auth/login

Request

{
  "email": "ali@test.com",
  "password": "123456"
}

Responses

200 OK
{
  "token": "JWT_TOKEN"
}

400 Bad Request
{
  "timestamp": "2026-05-06T12:00:00.000+00:00",
  "status": 400,
  "error": "Bad Request",
  "message": "email: must be a well-formed email address",
  "path": "/api/auth/login"
}

401 Unauthorized (invalid credentials)
{
  "timestamp": "2026-05-06T12:00:00.000+00:00",
  "status": 401,
  "error": "Unauthorized",
  "message": "Invalid email or password.",
  "path": "/api/auth/login"
}

## Health

GET /health

Responses

200 OK
{
  "status": "ok"
}

## Notes

- Token is a JWT signed with HS256 and includes subject = userId, role, and exp.
- All other services expect Authorization: Bearer <token>.
