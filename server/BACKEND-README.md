Running database

```docker compose -f ./docker/docker-compose.yml up --detach -V```

Running app

```./mvnw spring-boot:run```

Credentials for database

```
url=jdbc:postgresql://localhost:5432/postgres
username=postgres
password=postgres
database_name=postgres
```

Initializing database

//TODO: Add script to initialize database with example data

```Run script from src/main/resources/scripts/initialize.sql```

To access Swagger documentation visit

```http://localhost:8080/swagger-ui/index.html#/```

To stop database

```docker-compose -f ./docker/docker-compose.yml down -v```