import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Import do Provider
import 'controller/posts_controller.dart'; // Import do controlador
import 'screen/posts_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PostsController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buscar Posts API',
      home: PostsScreen(),
    );
  }
}