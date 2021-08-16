import 'package:flutter/material.dart';
import 'package:pelitoday/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PeliToday'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search_off_outlined),
            onPressed: () {}
          )
        ],
      ),
      body: Column(
      children: [
        CardSwipper()
      ]
    ));
  }
}