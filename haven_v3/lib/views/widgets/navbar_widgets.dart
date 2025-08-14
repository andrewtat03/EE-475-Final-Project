import 'package:flutter/material.dart';
import 'package:haven_v3/data/notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier, 
      builder: (context, selectedPage, child) {
        return Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8.0,
                offset: Offset(0, -4),
              ),
            ],
          ),
          
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child:
              NavigationBar(
                labelTextStyle: WidgetStateProperty.all(
                  TextStyle(
                    color: Colors.black, // Navbar label Color
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                destinations: [
                  NavigationDestination(
                    icon: Icon(
                      Icons.home_outlined,
                      color: Colors.black,
                    ), 
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.devices_other,
                      color: Colors.black,
                    ), 
                    label: 'Devices',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                    ), 
                    label: 'AR',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.add_box_outlined,
                      color: Colors.black,
                    ), 
                    label: 'Groups',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.more_horiz_rounded,
                      color: Colors.black,
                    ), 
                    label: 'More',
                  ),
                ],
                onDestinationSelected: (int value) {
                  selectedPageNotifier.value = value;
                },
                selectedIndex: selectedPage,
              ),
          ),
        );
      },
    );
  }
}