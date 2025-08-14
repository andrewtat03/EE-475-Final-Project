import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haven_v3/views/widgets/sensor_card.dart';

class AddFavoritesPage extends StatefulWidget {
  final Set<String> favoriteDocIds;
  final Function(String docId) onToggleFavorite;

  const AddFavoritesPage({
    Key? key,
    required this.favoriteDocIds,
    required this.onToggleFavorite,
  }) : super(key: key);

  @override
  State<AddFavoritesPage> createState() => _AddFavoritesPageState();
}

class _AddFavoritesPageState extends State<AddFavoritesPage> {
  void _handleToggle(String docId) {
    widget.onToggleFavorite(docId);
    setState(() {}); // Trigger rebuild to update the star icon
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add to Favorites"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('stickers').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: docs.map((doc) {
                final docPath = 'stickers/${doc.id}';
                final isFavorite = widget.favoriteDocIds.contains(doc.id);

                return Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    SensorCard(docPath: docPath),
                    IconButton(
                      onPressed: () => _handleToggle(doc.id),
                      icon: Icon(
                        isFavorite ? Icons.star : Icons.star_border,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}