// backend/routes/research.js
const express = require('express');
const { createResearch, getAllResearch, getResearchById, deleteResearch } = require('../controllers/researchController');
const { authMiddleware } = require('../middlewares/authMiddleware');

const router = express.Router();

// Create Research Paper
router.post('/', authMiddleware, createResearch);

// Get all Research Papers
router.get('/', getAllResearch);

// Get Research Paper by ID
router.get('/:id', getResearchById);

// Delete Research Paper
router.delete('/:id', authMiddleware, deleteResearch);

module.exports = router;
