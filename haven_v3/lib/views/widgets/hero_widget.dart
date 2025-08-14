import 'package:flutter/material.dart';

class HeroWidget extends StatelessWidget { // transitions a widget smoothly between pages
  const HeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'hero1',
      child: ClipRRect( // create rounded borders for any widget
        borderRadius: BorderRadius.circular(20),
        child: Image.asset('assets/images/bg.jpg',
          color: Colors.blue,
          colorBlendMode: BlendMode.darken,
        ),
      ),
    );
  }
}