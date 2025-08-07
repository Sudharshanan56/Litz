import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:litz/Bottom%20Navigation/Navigation.dart';

class AllUsersScreen extends StatelessWidget {
  const AllUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usersCollection = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Navigation())),
        child: Icon(Icons.arrow_back_ios)),
        title: Text('All Users'),
        backgroundColor: Colors.deepOrange,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data?.docs ?? [];

          if (users.isEmpty) {
            return Center(child: Text("No users found"));
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final doc = users[index];
              final data = doc.data() as Map<String, dynamic>;
              final uid = doc.id;

              final username = data['username'] ?? 'Unknown';
              final email = data['email'] ?? 'N/A';
              final points = data['points'] ?? 0;

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(username),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email: $email"),
                      Text("UID: $uid"),
                      Text("Points: $points"),
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
