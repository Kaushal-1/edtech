// backend/controllers/notesController.js
const Note = require('../models/noteModel');

// Create a new Note
const createNote = async (req, res) => {
    const { title, description, fileUrl } = req.body;

    try {
        const note = new Note({
            title,
            description,
            fileUrl,
            uploadedBy: req.user.user_id,
        });

        await note.save();
        res.status(201).json({ message: 'Note uploaded successfully', note });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// Get all Notes
const getAllNotes = async (req, res) => {
    try {
        const notes = await Note.find().populate('uploadedBy', 'name email');
        res.status(200).json(notes);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// Get Note by ID
const getNoteById = async (req, res) => {
    const { id } = req.params;

    try {
        const note = await Note.findById(id).populate('uploadedBy', 'name email');

        if (!note) {
            return res.status(404).json({ message: 'Note not found' });
        }

        res.status(200).json(note);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// Delete Note
const deleteNote = async (req, res) => {
    const { id } = req.params;

    try {
        const note = await Note.findById(id);

        if (!note) {
            return res.status(404).json({ message: 'Note not found' });
        }

        await note.remove();

        res.status(200).json({ message: 'Note deleted successfully' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

module.exports = {
    createNote,
    getAllNotes,
    getNoteById,
    deleteNote,
};
