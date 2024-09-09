import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<dynamic> posts = [];

  // Lista de cores do arco-íris
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
    final dio = Dio(); // Instância do Dio
    const url = 'https://jsonplaceholder.typicode.com/posts';

    try {
      // Fazendo a requisição GET
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        setState(() {
          posts = response.data;
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
        title: const Text('Posts com Dio'),
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