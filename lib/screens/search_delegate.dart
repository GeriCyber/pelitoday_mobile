import 'package:flutter/material.dart';
import 'package:pelitoday/models/movie.dart';
import 'package:pelitoday/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {

  @override
  String? get searchFieldLabel => 'Search Movie';

  // Search actions
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '', 
        icon: Icon(Icons.clear)
      )
    ];
  }

  // Search leave screen
  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
        onPressed: () => close(context, null), 
        icon: Icon(Icons.arrow_back)
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _listResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _listResults(context);
  }

  Widget _emptyContainer() {
    return Container(
        child: Center(
          child: Icon(
            Icons.local_movies_outlined, color: Colors.black38, size: 120
          ),
        )
      ); 
  }

  Widget _listResults(BuildContext context) {
    if(query.isEmpty) {
      return _emptyContainer();
    }

    final size = MediaQuery.of(context).size;
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder:(_, AsyncSnapshot<List<Movie>> snapshot) {
        print(snapshot.connectionState);
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container(
              width: double.infinity,
              height: size.height * 0.5,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.greenAccent.shade200, strokeWidth: 5.0
                )
              )
            );
            case ConnectionState.active: 
              final movies = snapshot.data!;
              if(movies.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (_, int index) => _MovieItem(movies[index]),
                  itemCount: movies.length,
                );
              }
              return _emptyContainer();
          default:
            return _emptyContainer();
        }
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';
    final date = movie.releaseDate != null && movie.releaseDate != '' ? DateTime.parse(movie.releaseDate!).year : '';
    return Hero(
      tag: movie.heroId!,
      child: ListTile(
        leading: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.contain,
        ),
        title: Text(movie.title, style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.bold)),
        subtitle: Text('${date}', style: TextStyle(fontFamily: 'Lato')),
        onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
      ),
    );
  }
}