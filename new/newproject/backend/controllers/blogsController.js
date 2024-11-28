// backend/controllers/blogsController.js
const Blog = require('../models/blogModel');

// Create a new Blog
const createBlog = async (req, res) => {
    const { title, content } = req.body;

    try {
        const blog = new Blog({
            title,
            content,
            author: req.user.user_id,
        });

        await blog.save();
        res.status(201).json({ message: 'Blog created successfully', blog });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// Get all Blogs
const getAllBlogs = async (req, res) => {
    try {
        const blogs = await Blog.find().populate('author', 'name email');
        res.status(200).json(blogs);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// Get Blog by ID
const getBlogById = async (req, res) => {
    const { id } = req.params;

    try {
        const blog = await Blog.findById(id).populate('author', 'name email');

        if (!blog) {
            return res.status(404).json({ message: 'Blog not found' });
        }

        res.status(200).json(blog);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// Update Blog
const updateBlog = async (req, res) => {
    const { id } = req.params;
    const { title, content } = req.body;

    try {
        const blog = await Blog.findById(id);

        if (!blog) {
            return res.status(404).json({ message: 'Blog not found' });
        }

        blog.title = title || blog.title;
        blog.content = content || blog.content;

        await blog.save();

        res.status(200).json({ message: 'Blog updated successfully', blog });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// Delete Blog
const deleteBlog = async (req, res) => {
    const { id } = req.params;

    try {
        const blog = await Blog.findById(id);

        if (!blog) {
            return res.status(404).json({ message: 'Blog not found' });
        }

        await blog.remove();

        res.status(200).json({ message: 'Blog deleted successfully' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

module.exports = {
    createBlog,
    getAllBlogs,
    getBlogById,
    updateBlog,
    deleteBlog,
};
