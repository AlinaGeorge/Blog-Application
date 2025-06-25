import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/post_list_screen.dart';
import 'screens/create_post_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/posts': (context) => PostListScreen(),
        '/create': (context) => CreatePostScreen(),
      },
    );
  }
}
