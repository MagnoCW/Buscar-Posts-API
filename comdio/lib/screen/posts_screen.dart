import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/posts_controller.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postsController = Provider.of<PostsController>(context);

    // Fetch posts when the screen is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      postsController.fetchPosts();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts com Dio'),
      ),
      body: Consumer<PostsController>(
        builder: (context, controller, child) {
          if (controller.posts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              final color = controller.getColorForIndex(index);

              return Container(
                color: color,
                child: ListTile(
                  title: Text(controller.posts[index]['title']),
                  subtitle: Text(controller.posts[index]['body']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}