from flask import Flask, request, jsonify
import random

app = Flask(__name__)

# Mock data for recommendations
content_data = {
    "notes": ["Note 1", "Note 2", "Note 3"],
    "research_papers": ["Paper A", "Paper B", "Paper C"],
    "blogs": ["Blog X", "Blog Y", "Blog Z"]
}

@app.route('/recommend', methods=['GET'])
def recommend():
    content_type = request.args.get('type', 'notes')
    if content_type not in content_data:
        return jsonify({"error": "Invalid content type"}), 400
    recommendations = random.sample(content_data[content_type], 2)
    return jsonify({"recommendations": recommendations})

if __name__ == '__main__':
    app.run(port=6000, debug=True)
