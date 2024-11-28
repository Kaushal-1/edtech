// backend/routes/blogs.js
const express = require('express');
const { createBlog, getAllBlogs, getBlogById, updateBlog, deleteBlog } = require('../controllers/blogsController');
const { authMiddleware } = require('../middlewares/authMiddleware');

const router = express.Router();

// Create Blog
router.post('/', authMiddleware, createBlog);

// Get all Blogs
router.get('/', getAllBlogs);

// Get Blog by ID
router.get('/:id', getBlogById);

// Update Blog
router.put('/:id', authMiddleware, updateBlog);

// Delete Blog
router.delete('/:id', authMiddleware, deleteBlog);

module.exports = router;
