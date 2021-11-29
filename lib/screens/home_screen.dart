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
            icon: Icon(Icons.search_outlined),
            onPressed: () {}
          )
        ],
      ),
      body: SingleChildScrollView(child: 
        Column(
          children: [
            // Main cards
            CardSwipper(),
            // Movies slider
            MovieSlider(),
          ]
        )
      )
    );
  }
}