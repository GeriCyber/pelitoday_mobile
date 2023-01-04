import 'package:flutter/material.dart';
import 'package:pelitoday/screens/search_delegate.dart';
import 'package:pelitoday/providers/movies_provider.dart';
import 'package:pelitoday/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('PeliToday'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search_outlined),
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate())
          )
        ],
      ),
      body: SingleChildScrollView(child: 
        Column(
          children: [
            // Main cards
            CardSwipper(
              movies: moviesProvider.onDisplayMovies,
              title: 'Now Playing',
            ),
            // Movies slider
            MovieSlider(
                movies: moviesProvider.popularMovies, 
                title: 'Most Popular Movies',
                onNextPage: () => moviesProvider.getPopularMovies(),
              ),
          ]
        )
      )
    );
  }
}