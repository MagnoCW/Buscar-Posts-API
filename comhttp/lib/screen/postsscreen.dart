import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonDecode;

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<dynamic> posts = [];

  // Lista de cores
  final List<Color> rainbowColors = [
    Colors.yellow,
    Colors.green,
    Colors.blue,
  ];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> fetchedPosts = jsonDecode(response.body);
        setState(() {
          posts = fetchedPosts;
        });
      } else {
        if (kDebugMode) {
          print('Erro: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Ocorreu um erro: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts API'),
      ),
      body: posts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                // Alterna as cores de acordo com o índice
                final color = rainbowColors[index % rainbowColors.length];

                return Container(
                  color: color,
                  child: ListTile(
                    title: Text(posts[index]['title']),
                    subtitle: Text(posts[index]['body']),
                  ),
                );
              },
            ),
    );
  }
}