import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/post_model.dart';
import 'post_detail_screen.dart';

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  List<Post> posts = [];
  bool isLoading = true;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _fetchPosts();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getString('token') != null;
    });
  }

  Future<void> _fetchPosts() async {
    final response = await http.get(Uri.parse('http://192.168.1.4:8000/api/posts/'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      setState(() {
        posts = jsonData.map((item) => Post.fromListJson(item)).toList();

        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load posts')),
      );
    }
  }

  void _navigateToPostDetail(Post post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostDetailScreen(postId: post.id),
      ),
    );
  }

  void _navigateToCreatePost() {
    Navigator.pushNamed(context, '/create');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Blog Posts')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : posts.isEmpty
              ? Center(child: Text("No posts available"))
              : ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: ListTile(
                        title: Text(post.title),
                        subtitle: Text(post.summary),
                        trailing: Text(post.createdAt.split('T')[0]),
                        onTap: () => _navigateToPostDetail(post),
                      ),
                    );
                  },
                ),
      floatingActionButton: isLoggedIn
          ? FloatingActionButton(
              onPressed: _navigateToCreatePost,
              child: Icon(Icons.add),
              tooltip: 'Create New Post',
            )
          : null,
    );
  }
}
