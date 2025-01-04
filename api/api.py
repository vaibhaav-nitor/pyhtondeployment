from flask import Flask, jsonify, request
from pymongo import MongoClient
import os

api = Flask(__name__)

# MongoDB configurations
MONGO_URI = os.getenv("MONGO_URI", "mongodb://mongodb-svc:27017/")
client = MongoClient(MONGO_URI)

# Database and collection configuration
db = client["quotesdb"]
quotes_collection = db["quotes"]


@api.route("/api/quotes", methods=["GET"])
def get_quotes():
    """Fetch all quotes from MongoDB."""
    quotes = list(quotes_collection.find({}, {"_id": 0}))  # Exclude MongoDB _id field
    return jsonify(quotes), 200


@api.route("/ok", methods=["GET"])
def health():
    """OK check endpoint."""
    return "OK", 200


@api.route("/api/quotes", methods=["POST"])
def add_quote():
    """Add a new quote to MongoDB."""
    data = request.get_json()
    if not data or "quote" not in data or "author" not in data:
        return jsonify({"error": "Both 'quote' and 'author' are required."}), 400

    content = data["quote"]
    author = data["author"]
    
    # Insert a new quote into MongoDB
    result = quotes_collection.insert_one({"quote": content, "author": author})
    
    return jsonify({"id": str(result.inserted_id), "quote": content, "author": author}), 201


if __name__ == "__main__":
    # Use the PORT environment variable, default to 5001 for local development
    port = int(os.environ.get("PORT", 5001))
    api.run(host="0.0.0.0", port=port, debug=True)
