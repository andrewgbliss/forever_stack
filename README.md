# Forever Stack 

A stack of everything, together, forever

## Docker Compose Stack

- NGINX
- Postgres Db
- Perl localhost
- PHP localhost
- NextJs, tailwind, shadcn, drizzle orm
- Java Backend
- Go Backend
- Ruby Backend
- Python Backend

```docker compose

```

These will all tack to each other, they are all listening on different ports. 
You can make them public or internal in the docker compose: here is an example:

```docker compose

```

### Drizzle ORM

This will manage migrations, type safety, and a basic API exposed at /api.

Each of the other services will be on different ports. Like the PERL api will be on localhost:5000

### Localhost 

On port 80 will be the NextJs server rendering react.

### Env

```env
DATABASE_URL=DATABASE_URL=postgresql://postgres:postgres@{domain name or ip}:{port}/postgres
POSTGRES_PASSWORD=postgres
POSTGRES_USER=postgres
POSTGRES_DB=postgres
```