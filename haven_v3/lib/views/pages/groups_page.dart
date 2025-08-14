import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haven_v3/views/widgets/group_card.dart';

class GroupsPage extends StatelessWidget {
  final Set<String> favoriteGroupIds;
  final Function(String groupId) onToggleFavorite;

  const GroupsPage({
    super.key,
    required this.favoriteGroupIds,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('stickers').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

        final docs = snapshot.data!.docs;

        // Collect all groupIDs
        final groupIds = docs
            .map((doc) => doc.data() as Map<String, dynamic>?) // safely cast data
            .where((data) => data != null && data.containsKey('groupID'))
            .map((data) => data!['groupID'])
            .toSet()
            .toList();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: groupIds.map<Widget>((id) {
              final isFavorite = favoriteGroupIds.contains(id);

              return Stack(
                alignment: Alignment.topLeft,
                children: [
                  GroupCard(
                    groupId: id,
                    isFavorite: isFavorite,
                    onToggleFavorite: onToggleFavorite,
                  ),
                  IconButton(
                    onPressed: () => onToggleFavorite(id),
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
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haven_v3/views/widgets/group_card.dart';

class GroupsPage extends StatelessWidget {
  final bool isFavorite;
  final Function(String groupID) onToggleFavorite;
 
  const GroupsPage({
    super.key,
    required this.groupID,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('stickers').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

        final docs = snapshot.data!.docs;

        // Collect all groupIDs
        final groupIds = docs
            .map((doc) => doc.data() as Map<String, dynamic>?) // safely cast data
            .where((data) => data != null && data.containsKey('groupID'))
            .map((data) => data!['groupID'])
            .toSet()
            .toList();

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Wrap(
              spacing: 10.0,
              runSpacing: 2.0,
              children: groupIds
                  .map<Widget>((id) => GroupCard(groupId: id))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
*/