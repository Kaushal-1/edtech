// server.js
const express = require('express');
const connectDB = require('./config/database');
const app = express();
require('dotenv').config();
const cors = require('cors');
// Connect Database
connectDB();

// Middleware to parse request body
app.use(cors()); // Enable CORS for all routes
app.use(express.json());

// Define Routes
app.use('/api/users', require('./routes/users'));
app.use('/api/notes', require('./routes/notes')); // For handling notes
app.use('/api/articles', require('./routes/articles')); // For articles, blogs, etc.

// Starting the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server started on port ${PORT}`));