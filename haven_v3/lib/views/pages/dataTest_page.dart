import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataTestPage extends StatefulWidget {
  const DataTestPage({super.key});

  @override
  State<DataTestPage> createState() => _DataTestPageState();
}

class _DataTestPageState extends State<DataTestPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Count Demo',
      home: CountScreen(), // Loads our simple UI
      debugShowCheckedModeBanner: false,
    );
  }
}

class CountScreen extends StatelessWidget {
  final String docPath = 'counts/myCounter'; // Path to the document in Firestore

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Live Count')),
      body: Center(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.doc(docPath).snapshots(),
          builder: (context, snapshot) {
            // Show a loading spinner while waiting for data
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            // Extract the count value (default to 0 if missing)
            final data = snapshot.data!.data() as Map<String, dynamic>?;
            final count = data?['count'] ?? 0;

            // UI showing the label and the live count
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Current Count:',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 10),
                Text(
                  '$count',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}