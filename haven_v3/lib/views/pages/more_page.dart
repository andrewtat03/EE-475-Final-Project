import 'package:flutter/material.dart';
import 'package:haven_v3/views/pages/welcome_page.dart';


class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              spacing: 6.0, // horizontal gap
              runSpacing: 2.0, // vertical gap if they wrap
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomePage()),
                    );
                  },
                  child: _buildMoreCard(
                    context, 
                    Icons.settings_outlined, 
                    'Settings',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomePage()),
                    );
                  },
                  child: _buildMoreCard(
                    context, 
                    Icons.notifications_outlined, 
                    'Notifications',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomePage()),
                    );
                  },
                  child: _buildMoreCard(
                    context, 
                    Icons.notes_outlined, 
                    'Notes',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomePage()),
                    );
                  },
                  child: _buildMoreCard(
                    context, 
                    Icons.calendar_month, 
                    'Reminders',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomePage()),
                    );
                  },
                  child: _buildMoreCard(
                    context, 
                    Icons.devices_other, 
                    'Devices',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomePage()),
                    );
                  },
                  child: _buildMoreCard(
                    context, 
                    Icons.report_outlined, 
                    'Reports',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomePage()),
                    );
                  },
                  child: _buildMoreCard(
                    context, 
                    Icons.dark_mode_outlined, 
                    'Appearance',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomePage()),
                    );
                  },
                  child: _buildMoreCard(
                    context, 
                    Icons.person_outline, 
                    'Account',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomePage()),
                    );
                  },
                  child: _buildMoreCard(
                    context, 
                    Icons.help_outline_outlined, 
                    'Help',
                  ),
                ),

              ],
            ),
          ],
        )
      ),
    );
  }
}


Widget _buildMoreCard(
  BuildContext context,
  IconData icon,
  String title,
) {
  return Container( // changes distance/padding around card
    width: 173.0,
    height: 75,
    padding: EdgeInsets.symmetric(
      vertical: 3.0,
    ),
    child: Card(
      child: Padding(
        padding: EdgeInsets.all(10.0), // padding inside of cards
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(icon, color: Colors.black.withOpacity(0.6), size: 25)
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title, 
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
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