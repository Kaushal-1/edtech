const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const cors = require('cors');

// Initialize app
const app = express();
app.use(cors());
app.use(bodyParser.json());

// MongoDB connection
mongoose.connect('mongodb://localhost:27017/edtech', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
}).then(() => console.log('Connected to MongoDB'))
  .catch(err => console.error(err));

// Routes
const notesRoutes = require('../routes/notes');
const researchRoutes = require('../routes/research');
const blogsRoutes = require('../routes/blogs');

app.use('/api/notes', notesRoutes);
app.use('/api/research', researchRoutes);
app.use('/api/blogs', blogsRoutes);

// Start server
app.listen(5000, () => {
    console.log('Server running on http://localhost:5000');
});
