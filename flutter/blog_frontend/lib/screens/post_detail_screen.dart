import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/post_model.dart';

class PostDetailScreen extends StatefulWidget {
  final int postId;

  PostDetailScreen({required this.postId});

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  Post? post;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPostDetail();
  }

  Future<void> _fetchPostDetail() async {
    final response = await http.get(Uri.parse('http://192.168.1.4:8000/api/posts/'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        post = Post.fromDetailJson(data);
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load post details')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post Detail')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : post == null
              ? Center(child: Text('No post found'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post!.title,
                          style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: 8),
                      Text('By ${post!.author} on ${post!.createdAt.split("T")[0]}'),
                      Divider(),
                      SizedBox(height: 8),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(post!.content),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
