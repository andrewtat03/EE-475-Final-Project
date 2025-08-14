import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  final String groupId;
  final bool isFavorite;
  final Function(String groupID) onToggleFavorite;

  const GroupCard({
    Key? key,
    required this.groupId,
    required this.isFavorite,
    required this.onToggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 201,
      padding: EdgeInsets.symmetric(
        vertical: 3.0,
      ),

      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
              .collection('stickers')
              .where('groupID', isEqualTo: groupId)
              .snapshots(),
            builder: (context, snapshot) {
              // Show a loading spinner while waiting for data
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              final docs = snapshot.data!.docs;

              print('GroupCard for groupId "$groupId": ${docs.length} docs');
              for (var doc in docs) {
                print('Doc: ${doc.id}, data: ${doc.data()}');
              }

              if (docs.length < 2) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("No paired stickers....",
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark, 
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                );
              }
              
              // Extract the count value (default to 0 if missing)
              List<Widget> stacks = docs.take(2).map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                final peripheralInput = data['value'] ?? 0;
                final peripheralTitle = data['peripheral'] ?? 'Loading...';

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 115,
                      height: 115,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0),
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
                );
              }).toList();

              
              // UI showing the label and the live count
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: stacks,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30), // High radius = capsule shape
                        ),
                        child: Text(
                          '${docs.first['peripheral']} / ${docs.last['peripheral']}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ]
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  final String groupId;

  const GroupCard({
    Key? key,
    required this.groupId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String docPath = 'counts/myCounter';

    return Container(
      width: double.infinity,
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
              final peripheralInput = data?[peripheral] ?? 0;
              final peripheralTitle = data?['peripheral'] ?? 'Loading...';
              
              // UI showing the label and the live count
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 115,
                                  height: 115,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0),
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
                                          peripheral == 'Temperature'
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
                                                'F',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black.withOpacity(0.1),
                                                  height: 0.6,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          )
                                          : peripheral == 'Humidity'
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
                                  peripheral == 'Temperature'
                                    ? Icon(Icons.thermostat, color: Theme.of(context).primaryColor, size: 30,)
                                  :  peripheral == 'Humidity'
                                    ? Icon(Icons.water_drop, color: Theme.of(context).primaryColor, size: 30,)
                                  : Icon(Icons.wb_sunny, color: Theme.of(context).primaryColor, size: 30,),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 115,
                                  height: 115,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0),
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
                                          peripheral == 'Temperature'
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
                                                'F',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black.withOpacity(0.1),
                                                  height: 0.6,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          )
                                          : peripheral == 'Humidity'
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
                                  peripheral == 'Temperature'
                                    ? Icon(Icons.thermostat, color: Theme.of(context).primaryColor, size: 30,)
                                  :  peripheral == 'Humidity'
                                    ? Icon(Icons.water_drop, color: Theme.of(context).primaryColor, size: 30,)
                                  : Icon(Icons.wb_sunny, color: Theme.of(context).primaryColor, size: 30,),
                                  ],
                                ),
                              ],
                            ),
                          ],
                                          ),
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
                      '$peripheral / $peripheral',
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
*/