// screens/articles_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/article_service.dart'; // Service for managing articles
import '../widgets/custom_button.dart'; // Custom button widget

class ArticlesScreen extends StatefulWidget {
  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  List articles = [];

  @override
  void initState() {
    super.initState();
    _fetchArticles(); // Load articles when the screen is initialized
  }

  Future<void> _fetchArticles() async {
    final articleService = Provider.of<ArticleService>(context, listen: false);
    articles = await articleService.getArticles(); // Fetch articles from the service
    setState(() {}); // Update UI after fetching articles
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Articles'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(articles[index]['title']),
                    subtitle: Text(articles[index]['content']),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        await Provider.of<ArticleService>(context, listen: false)
                            .deleteArticle(articles[index]['_id']);
                        _fetchArticles(); // Refresh articles list
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _contentController,
                    decoration: InputDecoration(labelText: 'Content'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter content';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'Add Article',
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        await Provider.of<ArticleService>(context, listen: false)
                            .createArticle({
                          'title': _titleController.text,
                          'content': _contentController.text,
                        });
                        _titleController.clear();
                        _contentController.clear();
                        _fetchArticles(); // Refresh articles list
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}