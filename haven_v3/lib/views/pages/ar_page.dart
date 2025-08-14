import 'package:flutter/material.dart';

class ARPage extends StatelessWidget {
  const ARPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.08),
            ),
            child: Image.asset('assets/images/Icon.png')
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20,),
            child: Text(
              'AR Page (Under Construction)',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}