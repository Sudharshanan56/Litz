  // import 'dart:io';

  // import 'package:flutter/material.dart';
  // import 'package:image_picker/image_picker.dart';
  // import 'package:firebase_storage/firebase_storage.dart';
  // import 'package:cloud_firestore/cloud_firestore.dart';

  // class AdminPanel extends StatefulWidget {
  //   @override
  //   _AdminPanelState createState() => _AdminPanelState();
  // }

  // class _AdminPanelState extends State<AdminPanel> {
  //   File? _image;
  //   bool _uploading = false;

  //   final picker = ImagePicker();

  //   Future<void> _pickImage() async {
  //     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //     if (pickedFile != null) {
  //       setState(() {
  //         _image = File(pickedFile.path);
  //       });
  //     }
  //   }

  //   Future<void> _uploadImage() async {
  //     if (_image == null) return;

  //     setState(() {
  //       _uploading = true;
  //     });

  //     try {
  //       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //       final ref = FirebaseStorage.instance.ref().child('images/$fileName.jpg');
  //       await ref.putFile(_image!);
  //       final downloadUrl = await ref.getDownloadURL();

  //       // Save metadata to Firestore
  //       await FirebaseFirestore.instance.collection('images').add({
  //         'url': downloadUrl,
  //         'uploaded_at': Timestamp.now(),
  //       });

  //       setState(() {
  //         _image = null;
  //       });

  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(SnackBar(content: Text('Uploaded Successfully!')));
  //     } catch (e) {
  //       print('Error: $e');
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(SnackBar(content: Text('Upload failed!')));
  //     }

  //     setState(() {
  //       _uploading = false;
  //     });
  //   }

  //   @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       appBar: AppBar(title: Text('Admin Panel')),
  //       body: Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           children: [
  //             _image != null
  //                 ? Image.file(
  //                     _image!,
  //                     height: 200,
  //                     fit: BoxFit.cover,
  //                   )
  //                 : Text('No image selected.'),
  //             SizedBox(height: 20),
  //             ElevatedButton(onPressed: _pickImage, child: Text('Pick Image')),
  //             SizedBox(height: 10),
  //             ElevatedButton(
  //               onPressed: _uploading ? null : _uploadImage,
  //               child:
  //                   _uploading
  //                       ? CircularProgressIndicator()
  //                       : Text('Upload to Firebase'),
  //             ),
  //             Divider(height: 40),
  //             Expanded(child: _buildUploadedImagesList()),
  //           ],
  //         ),
  //       ),
  //     );
  //   }

  //   Widget _buildUploadedImagesList() {
  //     return StreamBuilder<QuerySnapshot>(
  //       stream:
  //           FirebaseFirestore.instance
  //               .collection('images')
  //               .orderBy('uploaded_at', descending: true)
  //               .snapshots(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasError) return Text('Error loading images');
  //         if (!snapshot.hasData) return Text('Uploaded images will appear here.');

  //         final docs = snapshot.data!.docs;

  //         if (docs.isEmpty) return Text('No images uploaded yet.');

  //         return ListView.builder(
  //           itemCount: docs.length,
  //           itemBuilder: (context, index) {
  //             final data = docs[index].data() as Map<String, dynamic>;
  //             final imageUrl = data['url'];

  //             return Padding(
  //               padding: const EdgeInsets.symmetric(vertical: 8.0),
  //               child: Image.network(imageUrl, height: 150),
  //             );
  //           },
  //         );
  //       },
  //     );
  //   }
  // }
