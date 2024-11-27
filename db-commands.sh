# # Run the mysql db
# docker run id/name_of_image  # This should start a mysql connection

# # While the connection is open, open a new terminal so we can interact with bash in the container
# docker exec -it containername/id /bin/bash # or /bin/sh


# # We should now be inside our container
# ls # check the file structure, there should be all the files and folders

# # CD into the 'docker-entrypoint-init.d' to verify the .sql file in there
# cd docker-entrypoint-init.d  

# # CD out of the folder, and acces mysql
# cd ..
# mysql -proot # attach the password, which is root

# # Now we are using mysql database, so we can check the databaes, tables etc..
# # Let's show all databases available
# show databases;

# # Pick our database
# use quote;

# # Show tables (shows quotes table)
# show tables;

# # Query the table (should see some data)
# select * from quotes;





# Run the mangodb db
docker run --name mongodb-container -d mongo:latest  # Start MongoDB container
  # This should start a mysql connection

# While the connection is open, open a new terminal so we can interact with bash in the container
docker exec -it mongodb-container /bin/bash  # Enter the container


# We should now be inside our container
ls # check the file structure, there should be all the files and folders

cd docker-entrypoint-init.d  # Go to initialization scripts folder (if present)

# CD out of the folder, and acces mango
cd ..

exit  # Exit the container shell
docker exec -it mongodb-container mongo  # Connect to MongoDB


mongosh --host 172.18.0.2 --port 27017      command to coonect mongosedb 

show databases;  # List all MongoDB databases

use quotesdb;  # Switch to the 'quote' database

show collections;  # List all collections (tables) in the 'quote' database

db.quotes.find();  # Query all documents in the 'quotes' collection




























