// models/User.js
const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
  date: {
    type: Date,
    default: Date.now,
  },
  points: {
    type: Number,
    default: 0, // Default points for the user
  },
  badges: [
    {
      type: String, // Array of badge names
    },
  ],
});

// Export the User model
module.exports = mongoose.model('User', UserSchema);