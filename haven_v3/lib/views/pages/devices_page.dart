import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/sensor_card.dart';

class DevicesPage extends StatefulWidget {
  final Set<String> favoriteDocIds;
  final Function(String docId) onToggleFavorite;

  const DevicesPage({
    super.key,
    required this.favoriteDocIds,
    required this.onToggleFavorite,
  });

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  void _handleToggle(String docId) {
    widget.onToggleFavorite(docId);
    setState(() {}); // Forces rebuild to update icon immediately
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('stickers').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
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
    );
  }
}

/*
class DevicesPage extends StatefulWidget {
  final Function(String docId) onAddToFavorites;

  const DevicesPage({Key? key, required this.onAddToFavorites}) : super(key : key);

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  Set<String> favoriteDocIds = {}; // store favorites
  
  void toggleFavorite(String docId) {
    setState(() {
      if (favoriteDocIds.contains(docId)) {
        favoriteDocIds.remove(docId);
      } else {
        favoriteDocIds.add(docId);
      }
    });

    widget.onAddToFavorites(docId);
  }
    

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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
              final data = doc.data() as Map<String, dynamic>;
              final peripheral = data['peripheral'] ?? 'Unknown';
              final docPath = 'stickers/${doc.id}';
              final isFavorite = favoriteDocIds.contains(doc.id);

              return Stack(
                alignment: Alignment.topLeft,
                children: [
                  SensorCard(peripheral: peripheral, docPath: docPath),
                  IconButton(
                    onPressed: () => toggleFavorite(doc.id),
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
*/

/*
import 'package:flutter/material.dart';
import '../widgets/sensor_card.dart';

class DevicesPage extends StatelessWidget {
  final Function(String peripheral) onAddToFavorites;

  const DevicesPage({Key? key, required this.onAddToFavorites}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    final peripherals = ['Temperature', 'Humidity', 'Light'];

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 10.0, // horizontal gap
              runSpacing: 2.0, // vertical gap if they wrap
              children: [
                SensorCard(peripheral: 'Temperature'),
                SensorCard(peripheral: 'Humidity'),
                SensorCard(peripheral: 'Light'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/