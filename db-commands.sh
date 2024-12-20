
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




























