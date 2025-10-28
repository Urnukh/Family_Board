# Use the official PostgreSQL image as the base
FROM postgres:latest

# Set environment variables for default database, user, and password
# (You can override these when you run the container or with docker-compose)
ENV POSTGRES_USER=famboard
ENV POSTGRES_PASSWORD=Almas2514
ENV POSTGRES_DB=dbfamboard

# Copy any initialization SQL scripts if you want to pre-seed the database
# (Optional: place your scripts in a folder called `initdb/`)
COPY ./initdb /docker-entrypoint-initdb.d/

# Expose PostgreSQL port
EXPOSE 5432