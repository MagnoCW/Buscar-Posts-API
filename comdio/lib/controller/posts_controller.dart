import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PostsController with ChangeNotifier {
  List<dynamic> _posts = [];
  final Dio _dio = Dio();
  final List<Color> _rainbowColors = [
    Colors.yellow,
    Colors.green,
    Colors.blue,
  ];

  List<dynamic> get posts => _posts;

  Color getColorForIndex(int index) {
    return _rainbowColors[index % _rainbowColors.length];
  }

  Future<void> fetchPosts() async {
    const url = 'https://jsonplaceholder.typicode.com/posts';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        _posts = response.data;
        notifyListeners(); // Notifica os widgets ouvintes sobre mudanças
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
}