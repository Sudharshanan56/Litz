import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CrudScreen extends StatefulWidget {
  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final CollectionReference users = FirebaseFirestore.instance.collection(
    'users',
  );

  String? editingId;

  Future<void> addUser() async {
    if (nameController.text.isNotEmpty && ageController.text.isNotEmpty) {
      await users.add({
        'name': nameController.text,
        'age': int.parse(ageController.text),
      });
      nameController.clear();
      ageController.clear();
    }
  }

  Future<void> updateUser() async {
    if (editingId != null) {
      await users.doc(editingId).update({
        'name': nameController.text,
        'age': int.parse(ageController.text),
      });
      setState(() => editingId = null);
      nameController.clear();
      ageController.clear();
    }
  }

  Future<void> deleteUser(String docId) async {
    await users.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase CRUD Example")),
      body: Container(
        color: const Color.fromARGB(255, 164, 59, 181),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name :',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: ageController,
                decoration: InputDecoration(
                  labelText: 'Age :',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            ElevatedButton(
              onPressed: editingId == null ? addUser : updateUser,
              child: Text(editingId == null ? "Add User" : "Save Changes"),
            ),

            Divider(),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: users.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();

                  final docs = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final data = doc.data() as Map<String, dynamic>;

                      return ListTile(
                        title: Text(
                          "Name: ${data['name']}",
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          "Age: ${data['age']}",
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                nameController.text = data['name'];
                                ageController.text = data['age'].toString();
                                setState(() => editingId = doc.id);
                              },
                            ),

                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deleteUser(doc.id),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
