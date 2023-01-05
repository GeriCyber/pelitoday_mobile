import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pelitoday/models/models.dart';
import 'package:pelitoday/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class GenreChips extends StatelessWidget {

  final int movieId;
  const GenreChips(this.movieId);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieGenres(movieId),
      builder: (_, AsyncSnapshot<List<Genre>> snapshot) {
        if(!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Genre> genres = snapshot.data!;

        if(genres.isNotEmpty) {
          return Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 20, top: 10),
                child: Text('Genres',
                  style: TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold, 
                    fontFamily: 'Lato'
                  )
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16.0, bottom: 10.0, top: 3.0, right: 16.0),
                width: double.infinity,
                height: 50,
                child: ListView.builder(
                  itemCount: genres.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) => _GenreChips(genres[index])
                ),
              )
            ],
          );
        }
        return SizedBox(height: 5);
      }
    );
  }
}

class _GenreChips extends StatelessWidget {

  final Genre genre;
  const _GenreChips(this.genre);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      // width: 110,
      height: 50,
      child: Column(
        children: [
          Chip(
            label: Text(genre.name),
          ),
        ]
      ),
    );
  }
}