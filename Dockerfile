# TODO: Implementar el Dockerfile para la aplicación

# Usar imagen base de Java 17
FROM openjdk:17-jdk-slim

# Establecer directorio de trabajo
WORKDIR /app

# Copiar el archivo pom.xml y mvnw para descargar dependencias
COPY pom.xml .
COPY mvnw .
COPY .mvn .mvn

# Dar permisos de ejecución al wrapper de Maven
RUN chmod +x mvnw

# Descargar dependencias
RUN ./mvnw dependency:go-offline

# Copiar el código fuente
COPY src ./src

# Compilar la aplicación
RUN ./mvnw clean package -DskipTests

# Exponer el puerto 8080
EXPOSE 8080

# Ejecutar la aplicación con el perfil docker
CMD ["java", "-jar", "-Dspring.profiles.active=docker", "target/demobase-0.0.1-SNAPSHOT.jar"]
