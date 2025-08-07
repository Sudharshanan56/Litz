import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:litz/Bottom%20Navigation/Navigation.dart';

class Post2 extends StatelessWidget {
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void postContent(BuildContext context) async {
    final about = aboutController.text.trim();
    final description = descriptionController.text.trim();

    if (about.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please fill all fields"),
      ));
      return;
    }

    await FirebaseFirestore.instance.collection('posts').add({
      'about': about,
      'description': description,
      'likes': 0,
      'timestamp': Timestamp.now(),
      'likedBy': [], // for tracking who liked
    });

    aboutController.clear();
    descriptionController.clear();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Post added successfully"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Navigation())),
        child: Icon(Icons.arrow_back_ios)),
        title: Text("Admin - Add Post")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: aboutController,
              decoration: InputDecoration(labelText: "About"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(labelText: "Description"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => postContent(context),
              child: Text("Post"),
            ),
          ],
        ),
      ),
    );
  }
}
