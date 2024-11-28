// backend/models/researchModel.js
const mongoose = require('mongoose');

const researchSchema = new mongoose.Schema({
    title: {
        type: String,
        required: true,
    },
    abstract: {
        type: String,
        required: true,
    },
    fileUrl: {
        type: String,
        required: true,
    },
    uploadedBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },
    createdAt: {
        type: Date,
        default: Date.now,
    },
});

const Research = mongoose.model('Research', researchSchema);

module.exports = Research;
