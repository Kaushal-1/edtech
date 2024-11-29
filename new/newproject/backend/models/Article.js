// models/Article.js
const mongoose = require('mongoose');

const ArticleSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  content: {
    type: String,
    required: true,
  },
  type: {
    type: String,
    required: true, // E.g., blog, research paper
  },
  media: {
    type: String,
    required: false, // Optional for articles without media
  },
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User', // Reference to the User model
    required: true,
  },
  date: {
    type: Date,
    default: Date.now,
  },
});

// Export the Article model
module.exports = mongoose.model('Article', ArticleSchema);