import 'package:flutter/material.dart';

class MoviesProvider extends ChangeNotifier {
  MoviesProvider() {
    print('Movies Provider initialized');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    print('getOnDisplayMovies');
  }
}