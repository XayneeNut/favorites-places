import 'package:flutter/material.dart';

class FavoritePlaceView extends StatelessWidget {
  const FavoritePlaceView({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text(
          'ini adalah favorite place',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
