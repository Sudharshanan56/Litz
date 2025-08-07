import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:litz/Bottom%20Navigation/Navigation.dart';

class Home2 extends StatelessWidget {
  const Home2({super.key});

  void toggleLike(DocumentSnapshot post, String uid) async {
    final postRef = FirebaseFirestore.instance.collection('posts').doc(post.id);
    final data = post.data() as Map<String, dynamic>;
    final likedBy = List<String>.from(data['likedBy'] ?? []);
    final isLiked = likedBy.contains(uid);

    if (isLiked) {
      await postRef.update({
        'likes': FieldValue.increment(-1),
        'likedBy': FieldValue.arrayRemove([uid]),
      });
    } else {
      await postRef.update({
        'likes': FieldValue.increment(1),
        'likedBy': FieldValue.arrayUnion([uid]),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Scaffold(body: Center(child: Text("User not logged in")));
    }

    final uid = user.uid;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Navigation())),
        child: Icon(Icons.arrow_back_ios)),
        title: Text("Posts")),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance
                .collection('posts')
                .orderBy('timestamp', descending: true)
                .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final posts = snapshot.data!.docs;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              final data = post.data() as Map<String, dynamic>;

              final about = data['about'] ?? '';
              final description = data['description'] ?? '';
              final likes = data['likes'] ?? 0;
              final likedBy = List<String>.from(data['likedBy'] ?? []);
              final isLiked = likedBy.contains(uid);

              return Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        about,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(description),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? Colors.red : Colors.grey,
                            ),
                            onPressed: () => toggleLike(post, uid),
                          ),
                          Text('$likes likes'),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.comment),
                            onPressed: () {
                              // You can navigate to a comment screen here
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
