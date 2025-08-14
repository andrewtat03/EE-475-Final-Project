import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class SensorCard extends StatelessWidget {
  //final String peripheral;
  final String docPath;
  
  const SensorCard({
    Key? key,
    //required this.peripheral,
    required this.docPath,
  }) : super(key: key);


  void _checkThresholdsAndNotify(BuildContext context, double value, String type) async {
    String? alertMsg;

    if (type == 'Temperature' && value > 85) {
      alertMsg = 'Temperature is too high: $value°F';
    } else if (type == 'Humidity' && value > 90) {
      alertMsg = 'Humidity is too high: $value%';
    } else if (type == 'Light' && value > 3000) {
      alertMsg = 'Light level is too high: $value lx';
    }

    if (alertMsg != null) {
      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'threshold_alerts',
        'Threshold Alerts',
        importance: Importance.max,
        priority: Priority.high,
      );

      const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

      await flutterLocalNotificationsPlugin.show(
        0,
        'Smart Sticker Alert',
        alertMsg,
        platformDetails,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 171.0,
      height: 201,
      padding: EdgeInsets.symmetric(
        vertical: 3.0,
      ),

      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.doc(docPath).snapshots(),
            builder: (context, snapshot) {
              // Show a loading spinner while waiting for data
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              
              // Extract the count value (default to 0 if missing)
              final data = snapshot.data!.data() as Map<String, dynamic>?;
              final peripheralInput = data?['value'] ?? 0;
              final peripheralTitle = data?['peripheral'] ?? 'Loading...';
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _checkThresholdsAndNotify(context, peripheralInput, peripheralTitle);
              });
              
              // UI showing the label and the live count
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 115,
                        height: 115,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            //color: Colors.yellow,
                            padding: EdgeInsets.zero,
                            height: 35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  //color: Colors.blue,
                                  padding: EdgeInsets.zero,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$peripheralInput',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(0.1),
                                        height: 0.8,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2),
                                peripheralTitle == 'Temperature'
                                ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '°',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black.withOpacity(0.1),
                                        height: 0.6,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'C',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black.withOpacity(0.1),
                                        height: 0.6,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                                : peripheralTitle == 'Humidity'
                                  ? Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      '%',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black.withOpacity(0.1),
                                        height: 1.2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      'lx',
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black.withOpacity(0.1),
                                        height: 1.2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        SizedBox(height: 3),
                        peripheralTitle == 'Temperature'
                          ? Icon(Icons.thermostat, color: Theme.of(context).primaryColor, size: 30,)
                        :  peripheralTitle == 'Humidity'
                          ? Icon(Icons.water_drop, color: Theme.of(context).primaryColor, size: 30,)
                        : Icon(Icons.wb_sunny, color: Theme.of(context).primaryColor, size: 30,),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30), // High radius = capsule shape
                    ),
                    child: Text(
                      peripheralTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}