const jwt = require('jsonwebtoken');

// Function to generate a token
const generateToken = (userId) => {
    return jwt.sign({ user_id: userId }, process.env.JWT_SECRET, {
        expiresIn: '1h', // Token expires in 1 hour
    });
};

module.exports = generateToken;
