# FROM mysql:latest
# ENV MYSQL_DATABASE=quotesdb \
#     MYSQL_ROOT_PASSWORD=root \
#     MYSQL_USER=user \
#     MYSQL_PASSWORD=password
# COPY init.sql /docker-entrypoint-initdb.d/


FROM mongo:latest
 
# Set environment variables for MongoDB (optional)
ENV MONGO_INITDB_ROOT_USERNAME=root \
    MONGO_INITDB_ROOT_PASSWORD=rootpassword \
    MONGO_INITDB_DATABASE=quotesdb


COPY init.js /docker-entrypoint-initdb.d/

# Expose the default MongoDB port
EXPOSE 27017
 
# Add any custom configuration files (optional)
# COPY mongo.conf /etc/mongo.conf
 
# Use the default MongoDB entrypoint (this is the default for the mongo image)
CMD ["mongod"]








