# Forex API

Set of APIs to store and display foreign exchange rate for currencies on a daily basis.

- Database Design: http://bit.ly/forex-api-db

- Documentation: http://bit.ly/forex-api-swagger

## Run
```shell
git clone https://github.com/roselinapradjanata/forex-api.git
cd forex-api
docker-compose up
```

This project is using docker, so only the command `docker-compose up` is necessary to run the project. The command will install all the dependencies, creating and migrating the database, run all unit tests, and finally run the server.

## Test
```shell
docker exec -it <container_id> rspec -fd
```

The command `docker-compose up` will already run all the unit tests, but if you want to run the test independently, you can type the command above.

## Author
| [<img src="https://avatars3.githubusercontent.com/u/23205832?s=400&v=4" width=60px style="border-radius: 50%;"><br /><sub>Roselina<br />Pradjanata</sub>](https://github.com/roselinapradjanata)
| :---: |
