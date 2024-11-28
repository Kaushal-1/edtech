// backend/controllers/userController.js
const User = require('../models/userModel');
const jwt = require('jsonwebtoken');

// Get User Profile
const getUserProfile = async (req, res) => {
    try {
        const user = await User.findById(req.user.user_id);

        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        res.status(200).json({
            name: user.name,
            email: user.email,
            createdAt: user.createdAt,
        });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// Update User Profile
const updateUserProfile = async (req, res) => {
    const { name, email } = req.body;

    try {
        const user = await User.findById(req.user.user_id);

        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        user.name = name || user.name;
        user.email = email || user.email;

        await user.save();

        res.status(200).json({
            message: 'User profile updated successfully',
            user: {
                name: user.name,
                email: user.email,
            },
        });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

module.exports = {
    getUserProfile,
    updateUserProfile,
};
