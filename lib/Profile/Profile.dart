import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:litz/Bottom%20Navigation/Navigation.dart';
import 'package:litz/Login/signup.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _nameController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final uid = user?.uid;
    if (uid != null) {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        final data = doc.data();
        _nameController.text = data?['name'] ?? '';
      }
    }
  }

  Future<void> saveName() async {
    final uid = user?.uid;
    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': _nameController.text.trim(),
        'email': user!.email,
        'uid': uid,
      }, SetOptions(merge: true));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed('/login'); // change to your login route
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("User not logged in")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Navigation())),
        child: Icon(Icons.arrow_back_ios)),
        title: const Text("Profile"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 50,child: Image.asset('assets/dp.png'),),
            Text("UID: ${user!.uid}", style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 10),
            Text("Email: ${user!.email ?? 'No email'}",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            
            const SizedBox(height: 30),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Navigation()));
                  },
                  child: ElevatedButton.icon(
                    onPressed: saveName,
                    icon: const Icon(Icons.save),
                    label: const Text("Save"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,foregroundColor: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Signup()));
                  },
                  child: ElevatedButton.icon(
                    onPressed: logout,
                    icon: const Icon(Icons.logout),
                    label: const Text("Logout"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
