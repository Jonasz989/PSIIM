Running database

```docker compose -f ./docker/docker-compose.yml up --detach -V```

Running app

```./mvnw spring-boot:run```

Initializing database

```Run script from src/main/resources/scripts/initialize.sql```