import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Points extends StatefulWidget {
  @override
  _PointsState createState() => _PointsState();
}

class _PointsState extends State<Points> {
  final TextEditingController _uidController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  Future<void> updateUserPoints() async {
    final String uid = _uidController.text.trim();
    final int pointsToAdd = int.tryParse(_pointsController.text.trim()) ?? 0;
    final String reason = _reasonController.text.trim();

    if (uid.isEmpty || pointsToAdd == 0 || reason.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Fill all fields correctly.")));
      return;
    }

    final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(userDoc);
        if (!snapshot.exists) {
          throw Exception("User not found");
        }

        final currentPoints = snapshot.get('points') ?? 0;
        transaction.update(userDoc, {'points': currentPoints + pointsToAdd});
      });

      // Log the reason to a subcollection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('points_log')
          .add({
            'points': pointsToAdd,
            'reason': reason,
            'date': Timestamp.now(),
          });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Points and reason saved")));

      // Clear fields
      _uidController.clear();
      _pointsController.clear();
      _reasonController.clear();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin - Update Points")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _uidController,
              decoration: InputDecoration(labelText: "User UID"),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _pointsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Points to Add"),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _reasonController,
              decoration: InputDecoration(labelText: "Reason for Points"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateUserPoints,
              child: Text("Update Points"),
            ),
          ],
        ),
      ),
    );
  }
}
