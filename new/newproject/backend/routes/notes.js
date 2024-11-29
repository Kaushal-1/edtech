// routes/notes.js
const express = require('express');
const router = express.Router();
const auth = require('../middlewares/auth');
const Note = require('../models/Note');

// @route   POST api/notes
// @desc    Create a new note
// @access  Private
router.post('/', auth, async (req, res) => {
  const { title, content, file } = req.body;

  try {
    const newNote = new Note({
      title,
      content,
      file, // link to the uploaded file
      user: req.user.id, // Attach user ID
    });

    const note = await newNote.save();
    res.status(201).json(note);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
});

// @route   GET api/notes
// @desc    Get all notes
// @access  Private
router.get('/', auth, async (req, res) => {
  try {
    const notes = await Note.find({ user: req.user.id });
    res.json(notes);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
});

// @route   DELETE api/notes/:id
// @desc    Delete a note
// @access  Private
router.delete('/:id', auth, async (req, res) => {
  try {
    const note = await Note.findById(req.params.id);
    if (!note) {
      return res.status(404).json({ msg: 'Note not found' });
    }

    // Check if the user owns the note
    if (note.user.toString() !== req.user.id) {
      return res.status(401).json({ msg: 'User not authorized' });
    }

    await note.remove();
    res.json({ msg: 'Note removed' });
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
});

module.exports = router;