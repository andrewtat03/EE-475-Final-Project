import 'package:flutter/material.dart';
import 'package:haven_v3/views/widgets/group_card.dart';
import '../widgets/sensor_card.dart';
import '../widgets/addNew_card.dart';
import 'package:haven_v3/views/pages/devices_page.dart';

class HomePage extends StatefulWidget {
  final Set<String> favoriteDocIds;
  final Set<String> favoriteGroupIds;
  final Function(String docId) onToggleFavorite;

  const HomePage({
    super.key,
    required this.favoriteDocIds,
    required this.onToggleFavorite,
    required this.favoriteGroupIds,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _addNewFavorite() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => DevicesPage(
        favoriteDocIds: widget.favoriteDocIds,
        onToggleFavorite: widget.onToggleFavorite,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                'Activity',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),

            _buildHomePageCardActivity(
              context,
              Icons.notifications,
              '2 new device notifications',
              'Listen to your notifications',
            ),
            _buildHomePageCardActivity(
              context,
              Icons.list,
              'Lorem ipsum dolor sit amet',
              'Lorem ipsum dolor sit amet',
            ),
            _buildHomePageCardActivity(
              context,
              Icons.play_arrow,
              'Lorem ipsum dolor sit amet',
              'Lorem ipsum dolor sit amet',
            ),

            const Padding(
              padding: EdgeInsets.only(top: 50, left: 5),
              child: Text(
                'Favorites',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),

            Wrap(
              spacing: 10.0,
              runSpacing: 2.0,
              children: [
                ...widget.favoriteDocIds.map((docId) => SensorCard(
                      docPath: 'stickers/$docId',
                    )),
                
                ...widget.favoriteGroupIds.map((groupId) => GroupCard(
                  groupId: groupId,
                  isFavorite: true, // They are favorites already
                  onToggleFavorite: widget.onToggleFavorite, // Optional
                )),
                
                GestureDetector(
                  onTap: _addNewFavorite,
                  child: const AddNewCard(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildHomePageCardActivity(
  BuildContext context,
  IconData icon,
  String title,
  String subtext,
) {
  return Container( // changes distance/padding around card
    width: double.infinity,
    padding: EdgeInsets.symmetric(
      vertical: 3.0,
    ),
    child: Card(
      child: Padding(
        padding: EdgeInsets.all(16.0), // padding inside of cards
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(icon, color: Theme.of(context).primaryColor, size: 30)
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, 
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(subtext,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
/*
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Set<String> _favoriteDocIds = {};

  void _addNewFavorite() async {
    await showModalBottomSheet(
      context: context, 
      builder: (context) => DevicesPage(
        onAddToFavorites: (String docId) {
          setState(() {
            if (!_favorites.contains(docId)) {
              _favorites.add(docId);
            }
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              margin: EdgeInsets.only(left: 5,),
              child: Text('Activity',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            _buildHomePageCardActivity(
              context, 
              Icons.notifications, 
              '2 new device notifications',
              'Listen to your notifications',
            ),
            _buildHomePageCardActivity(
              context, 
              Icons.list, 
              'Lorem ipsum dolor sit amet',
              'Lorem ipsum dolor sit amet',
            ),
            _buildHomePageCardActivity(
              context, 
              Icons.play_arrow, 
              'Lorem ipsum dolor sit amet',
              'Lorem ipsum dolor sit amet',
            ),

            Container(
              margin: EdgeInsets.only(top: 50, left: 5,),
              child: Text('Favorites',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            Wrap(
              spacing: 10.0, // horizontal gap
              runSpacing: 2.0, // vertical gap if they wrap
              children: [
                ..._favorites.map((docId) => SensorCard(
                  peripheral: 'Loading...', // optional placeholder; real one comes from Firestore
                  docPath: 'stickers/$docId',
                )).toList(),
                GestureDetector(
                  onTap: _addNewFavorite,
                  child: AddNewCard(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import '../widgets/sensor_card.dart';
import 'package:dotted_border/dotted_border.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              margin: EdgeInsets.only(left: 5,),
              child: Text('Activity',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            _buildHomePageCardActivity(
              context, 
              Icons.notifications, 
              '2 new device notifications',
              'Listen to your notifications',
            ),
            _buildHomePageCardActivity(
              context, 
              Icons.list, 
              'Lorem ipsum dolor sit amet',
              'Lorem ipsum dolor sit amet',
            ),
            _buildHomePageCardActivity(
              context, 
              Icons.play_arrow, 
              'Lorem ipsum dolor sit amet',
              'Lorem ipsum dolor sit amet',
            ),

            Container(
              margin: EdgeInsets.only(top: 50, left: 5,),
              child: Text('Favorites',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            Wrap(
              spacing: 10.0, // horizontal gap
              runSpacing: 2.0, // vertical gap if they wrap
              children: [
                SensorCard(peripheral: 'Temperature'),
                SensorCard(peripheral: 'Humidity'),
                SensorCard(peripheral: 'Light'),
                _buildAddNewCard(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildHomePageCardActivity(
  BuildContext context,
  IconData icon,
  String title,
  String subtext,
) {
  return Container( // changes distance/padding around card
    width: double.infinity,
    padding: EdgeInsets.symmetric(
      vertical: 3.0,
    ),
    child: Card(
      child: Padding(
        padding: EdgeInsets.all(16.0), // padding inside of cards
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(icon, color: Theme.of(context).primaryColor, size: 30)
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, 
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(subtext,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildAddNewCard(
  BuildContext context,
) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 8,
      horizontal: 3,
    ),
    child: DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      dashPattern: [6, 3], // 6px line, 3px gap
      color: Colors.black.withOpacity(0.1),
      strokeWidth: 1,
      child: Container(
        width: 160.0,
        height: 102,
        //padding: EdgeInsets.all(16),
        padding: EdgeInsets.symmetric(
          vertical: 7.0,
          horizontal: 5.0,
        ),
        child: Text(
          "+ Add new sensor/group", 
          style: TextStyle(
            color: Theme.of(context).primaryColorDark, 
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    ),
  );
}
*/