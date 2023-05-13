//Swagger urls:
http://localhost:8080/v2/api-docs
http://localhost:8080/swagger-ui/

//käivitamine command lines
mvn spring-boot:run -P dev

//käivitamine IntelliJ-s, kui käivitada CinemaApplication, siis run configuration kaudu määrata active profile

//pakke koostamine
mvn clean package -P prod

IntelliJ Community mured:

aktiivse profiili määramiseks "Modify run configuration", environments blokis määrata VM parameeter
-Dspring.profiles.active=profiil