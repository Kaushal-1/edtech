const jwt = require('jsonwebtoken');

const verifyToken = (token) => {
    try {
        return jwt.verify(token, process.env.JWT_SECRET); // Verify token
    } catch (error) {
        console.error('Token verification failed:', error.message);
        return null;
    }
};

module.exports = verifyToken;
