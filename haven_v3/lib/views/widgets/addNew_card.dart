import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({super.key});

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  @override
  Widget build(BuildContext context) {
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
          height: 183,
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
}