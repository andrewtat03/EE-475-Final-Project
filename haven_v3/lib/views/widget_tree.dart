import 'package:flutter/material.dart';
import 'package:haven_v3/data/notifiers.dart';
import 'package:haven_v3/views/pages/addFavorites_page.dart';
import 'package:haven_v3/views/pages/ar_page.dart';
import 'package:haven_v3/views/pages/devices_page.dart';
import 'package:haven_v3/views/pages/groups_page.dart';
import 'package:haven_v3/views/pages/home_page.dart';
import 'package:haven_v3/views/pages/more_page.dart';
import 'package:haven_v3/views/pages/dataTest_page.dart';
import 'widgets/navbar_widgets.dart';

List<String> pageTitles = [
  'Home',
  'Devices',
  'AR (Under Construction)',
  'Groups',
  'More (Under Construction)',
  'Add Device',
  'Data Test',
];

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  Set<String> favoriteDocIds = {};
  Set<String> favoriteGroupIds = {};

  void _toggleFavorite(String docId) {
    setState(() {
      if (favoriteDocIds.contains(docId)) {
        favoriteDocIds.remove(docId);
      } else {
        favoriteDocIds.add(docId);
      }
    });
  }

  void _toggleGroupFavorite(String groupId) {
    setState(() {
      if (favoriteGroupIds.contains(groupId)) {
        favoriteGroupIds.remove(groupId);
      } else {
        favoriteGroupIds.add(groupId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomePage(
        onToggleFavorite: _toggleFavorite,
        favoriteDocIds: favoriteDocIds,
        favoriteGroupIds: favoriteGroupIds,
      ),
      DevicesPage(
        onToggleFavorite: _toggleFavorite,
        favoriteDocIds: favoriteDocIds,
      ),
      ARPage(),
      GroupsPage(
        favoriteGroupIds: favoriteGroupIds,
        onToggleFavorite: _toggleGroupFavorite,
      ),
      MorePage(),
      AddFavoritesPage(onToggleFavorite: _toggleFavorite,
        favoriteDocIds: favoriteDocIds,
      ),
      DataTestPage(),
    ];

    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              pageTitles[selectedPage],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0), // padding between action icons and right side
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.black, size: 35),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddFavoritesPage(onToggleFavorite: _toggleFavorite, favoriteDocIds: favoriteDocIds,)),
                        );
                      },
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                    SizedBox(width: 0), // width between action icons
                    IconButton(
                      icon: Icon(Icons.notifications_none, color: Colors.black, size: 30),
                      onPressed: () {
                        
                      },
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: pages[selectedPage],
          bottomNavigationBar: NavbarWidget(),
        );
      },
    );
  }
}

/*
List<Widget> pages = [
  HomePage(),
  DevicesPage(onAddToFavorites: (String peripheral) { 
    print('Selected from DevicesPage: $peripheral');
   },),
  ARPage(),
  GroupsPage(),
  MorePage(),
  AddDevicesPage(),
  DataTestPage(),
];

List<String> pageTitles = [
  'Home',
  'Devices',
  'AR',
  'Groups',
  'More',
  'Add Device',
  'Data Test',
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: selectedPageNotifier, 
      builder: (context, selectedPage, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              pageTitles[selectedPage],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0), // padding between action icons and right side
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.black, size: 35),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddDevicesPage()),
                        );
                      },
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                    SizedBox(width: 0), // width between action icons
                    IconButton(
                      icon: Icon(Icons.notifications_none, color: Colors.black, size: 30),
                      onPressed: () {
                        
                      },
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: pages[selectedPage],
          bottomNavigationBar: NavbarWidget(),
        );
      },
    );
  }
}
*/