const express = require('express');
const router = express.Router();
const { registerUser, loginUser } = require('../controllers/authController');

router.post('/register', registerUser); // Endpoint for user registration
router.post('/login', loginUser);       // Endpoint for user login

module.exports = router;
