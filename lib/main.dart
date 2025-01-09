import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const PostsPage(),
    );
  }
}

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List posts = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPosts();
  }

  void fetchPosts() async {
    try {
      var response = await Dio().get('https://jsonplaceholder.typicode.com/posts');
      setState(() {
        posts = response.data;
      });
    } catch (e) {
        print('Error $e');
    }
  }


  void addPosts() async {
    try {
      var response = await Dio().post(
        'https://jsonplaceholder.typicode.com/posts',
        data: {
          'title': 'New Post',
          'body': 'This is the body of the new post.',
          'userId': 1
      }
      );
      print('Post Created: ${response.data}' );
    } catch (e) {
          print('Error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context,index){
                  return ListTile(
                    title: Text(posts[index]['title']),
                    subtitle: Text(posts[index]['body']),
                  );
                }),
          ),
          ElevatedButton(onPressed: addPosts, child: Text('Add Post'))
        ],
      ),
    );
  }
}
