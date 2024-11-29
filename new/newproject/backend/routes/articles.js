// routes/articles.js
const express = require('express');
const router = express.Router();
const auth = require('../middlewares/auth');
const Article = require('../models/article');

// @route   POST api/articles
// @desc    Create a new article
// @access  Private
router.post('/', auth, async (req, res) => {
  const { title, content, type, media } = req.body;

  try {
    const newArticle = new Article({
      title,
      content,
      type, // type of article (e.g., blog, research paper)
      media, // link to any media (images, PDFs, etc.)
      user: req.user.id, // Attach user ID
    });

    const article = await newArticle.save();
    res.status(201).json(article);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
});

// @route   GET api/articles
// @desc    Get all articles
// @access  Private
router.get('/', auth, async (req, res) => {
  try {
    const articles = await Article.find({ user: req.user.id });
    res.json(articles);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
});

// @route   DELETE api/articles/:id
// @desc    Delete an article
// @access  Private
router.delete('/:id', auth, async (req, res) => {
  try {
    const article = await Article.findById(req.params.id);
    if (!article) {
      return res.status(404).json({ msg: 'Article not found' });
    }

    // Check if the user owns the article
    if (article.user.toString() !== req.user.id) {
      return res.status(401).json({ msg: 'User not authorized' });
    }

    await article.remove();
    res.json({ msg: 'Article removed' });
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
});

module.exports = router;