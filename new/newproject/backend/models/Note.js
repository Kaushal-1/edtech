// models/Note.js
const mongoose = require('mongoose');

const NoteSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  content: {
    type: String,
    required: true,
  },
  file: {
    type: String,
    required: false, // Optional for notes without files
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

// Export the Note model
module.exports = mongoose.model('Note', NoteSchema);