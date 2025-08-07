// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class PointsScreen extends StatelessWidget {
//   const PointsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final String uid = FirebaseAuth.instance.currentUser!.uid;
//     final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);
//     final pointsLog = userDoc.collection('points_log').orderBy('date', descending: true);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("My Points"),
//         backgroundColor: Colors.deepOrange,
//       ),
//       body: Column(
//         children: [
//           // 🟠 Top: Total Points Centered
//           StreamBuilder<DocumentSnapshot>(
//             stream: userDoc.snapshots(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) return CircularProgressIndicator();

//               final data = snapshot.data!.data() as Map<String, dynamic>;
//               final totalPoints = data['points'] ?? 0;

//               return Container(
//                 height: MediaQuery.of(context).size.height * 0.3,
//                 width: double.infinity,
//                 color: Colors.deepOrange,
//                 alignment: Alignment.center,
//                 child: Text(
//                   "$totalPoints Points",
//                   style: TextStyle(
//                     fontSize: 40,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               );
//             },
//           ),

//           // 🔻 Bottom: Reason + Points List
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: pointsLog.snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

//                 final logs = snapshot.data!.docs;

//                 if (logs.isEmpty) {
//                   return Center(
//                     child: Text("No points history yet."),
//                   );
//                 }

//                 return ListView.builder(
//                   itemCount: logs.length,
//                   itemBuilder: (context, index) {
//                     final data = logs[index].data() as Map<String, dynamic>;
//                     final reason = data['reason'] ?? 'No reason';
//                     final points = data['points'] ?? 0;
//                     final date = data['date'] != null
//                         ? (data['date'] as Timestamp).toDate()
//                         : null;

//                     return ListTile(
//                       leading: CircleAvatar(
//                         backgroundColor: Colors.deepOrange,
//                         child: Text("+$points", style: TextStyle(color: Colors.white)),
//                       ),
//                       title: Text(reason),
//                       subtitle: date != null
//                           ? Text("${date.day}/${date.month}/${date.year}")
//                           : null,
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PointsScreen extends StatelessWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final uid = snapshot.data!.uid;
        final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);
        final pointsLog = userDoc.collection('points_log').orderBy('date', descending: true);

        return Scaffold(
          appBar: AppBar(
            title: const Text("My Points"),
            backgroundColor: Colors.deepOrange,
          ),
          body: Column(
            children: [
             
              StreamBuilder<DocumentSnapshot>(
                stream: userDoc.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const CircularProgressIndicator();

                  final data = snapshot.data!.data() as Map<String, dynamic>? ?? {};
                  final totalPoints = data['points'] ?? 0;

                  return Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    color: Colors.deepOrange,
                    alignment: Alignment.center,
                    child: Text(
                      "$totalPoints Points",
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),

              
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: pointsLog.snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final logs = snapshot.data!.docs;

                    if (logs.isEmpty) {
                      return const Center(
                        child: Text("No points history yet."),
                      );
                    }

                    return ListView.builder(
                      itemCount: logs.length,
                      itemBuilder: (context, index) {
                        final data = logs[index].data() as Map<String, dynamic>;
                        final reason = data['reason'] ?? 'No reason';
                        final points = data['points'] ?? 0;
                        final date = data['date'] != null
                            ? (data['date'] as Timestamp).toDate()
                            : null;

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            child: Text("+$points", style: const TextStyle(color: Colors.white)),
                          ),
                          title: Text(reason),
                          subtitle: date != null
                              ? Text("${date.day}/${date.month}/${date.year}")
                              : null,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
