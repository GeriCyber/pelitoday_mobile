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
    return Text('SEARCHHH');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty) {
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder:(_, AsyncSnapshot<List<Movie>> snapshot) {
        if(!snapshot.hasData) {
          return _emptyContainer();
        }

        final movies = snapshot.data!;

        return ListView.builder(
            itemBuilder: (_, int index) => _MovieItem(movies[index]),
            itemCount: movies.length,
          );
      },
    );
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
  
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';
    final date = DateTime.parse(movie.releaseDate!);
    return Hero(
      tag: movie.heroId!,
      child: ListTile(
        leading: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.contain,
        ),
        title: Text(movie.title),
        subtitle: Text('${date.year}'),
        onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
      ),
    );
  }
}