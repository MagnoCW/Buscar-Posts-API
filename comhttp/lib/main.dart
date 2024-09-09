import 'package:flutter/material.dart';
import 'screen/postsscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Buscar Posts API',
      home: PostsScreen(),
    );
  }
}