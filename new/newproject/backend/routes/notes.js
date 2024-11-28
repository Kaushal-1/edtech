// backend/routes/notes.js
const express = require('express');
const { createNote, getAllNotes, getNoteById, deleteNote } = require('../controllers/notesController');
const { authMiddleware } = require('../middlewares/authMiddleware');

const router = express.Router();

// Create Note
router.post('/', authMiddleware, createNote);

// Get all Notes
router.get('/', getAllNotes);

// Get Note by ID
router.get('/:id', getNoteById);

// Delete Note
router.delete('/:id', authMiddleware, deleteNote);

module.exports = router;
