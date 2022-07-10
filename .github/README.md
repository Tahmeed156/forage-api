# Forage

A myriad of research tools at your fingertips!

### Setup

- Install `docker`
- Run `docker-compose up`. Might need to do twice the first time.

### Commands

```bash
# Run all containers
docker-compose up 
docker-compose up --build  # Rebuild

# Django commands
docker-compose run django python manage.py createsuperuser  # Create your own user
docker-compose run django python manage.py makemigrations  # Create new migration files
docker-compose run django python manage.py migrate  # Update database with migration files
docker-compose run django python manage.py shell  # Open shell

# Stop and DELETE (!) all containers
docker-compose down

```

### Notes

- `docker-compose up --build` will update python packages according to `requirements.txt` but will not update database
- `docker-compose up` runs all `db/*.sql` files the first time the containers are setup