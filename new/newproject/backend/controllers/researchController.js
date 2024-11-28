// backend/controllers/researchController.js
const Research = require('../models/researchModel');

// Create a new Research Paper
const createResearch = async (req, res) => {
    const { title, abstract, fileUrl } = req.body;

    try {
        const research = new Research({
            title,
            abstract,
            fileUrl,
            uploadedBy: req.user.user_id,
        });

        await research.save();
        res.status(201).json({ message: 'Research paper uploaded successfully', research });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// Get all Research Papers
const getAllResearch = async (req, res) => {
    try {
        const researchPapers = await Research.find().populate('uploadedBy', 'name email');
        res.status(200).json(researchPapers);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// Get Research Paper by ID
const getResearchById = async (req, res) => {
    const { id } = req.params;

    try {
        const research = await Research.findById(id).populate('uploadedBy', 'name email');

        if (!research) {
            return res.status(404).json({ message: 'Research paper not found' });
        }

        res.status(200).json(research);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// Delete Research Paper
const deleteResearch = async (req, res) => {
    const { id } = req.params;

    try {
        const research = await Research.findById(id);

        if (!research) {
            return res.status(404).json({ message: 'Research paper not found' });
        }

        await research.remove();

        res.status(200).json({ message: 'Research paper deleted successfully' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

module.exports = {
    createResearch,
    getAllResearch,
    getResearchById,
    deleteResearch,
};

