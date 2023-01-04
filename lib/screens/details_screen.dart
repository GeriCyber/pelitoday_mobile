import 'package:flutter/material.dart';
import 'package:pelitoday/models/movie.dart';
import 'package:pelitoday/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie),
          SliverList(delegate: SliverChildListDelegate([
            _PosterAndTitle(movie),
            _Overview(movie),
            Container(
              margin: EdgeInsets.only(left: 20, top: 18),
              child: Text('Cast',
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                  fontFamily: 'Lato'
                )
              ),
            ),
            CastingCards(movie.id)
          ]))
        ]
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

    final Movie movie;
    const _CustomAppBar(this.movie);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.grey.shade900,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black12,
          child: Text(
            movie.title,
            style: TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 16
            ),
            textAlign: TextAlign.center,
          ),
        ),

        background: FadeInImage(
          image: NetworkImage(movie.fullBackdropPathImg),
          placeholder: AssetImage('assets/loading.gif'),
          fit: BoxFit.cover,
        )
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;
  const _PosterAndTitle(this.movie);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final date = movie.releaseDate != null && movie.releaseDate != '' ? DateTime.parse(movie.releaseDate!).year : '';

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                image: NetworkImage(movie.fullPosterImg),
                placeholder: AssetImage('assets/loading.gif'),
                height: 150,
              )
            ),
          ),
          SizedBox(width: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                  movie.title,
                  maxLines: 4,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis, 
                    fontFamily: 'Lato',
                    fontSize: 22,
                  )
                ),
                Padding(padding: EdgeInsets.only(bottom: 4)),
                Text(
                  '$date',
                  maxLines: 2,
                  style: TextStyle( 
                    fontFamily: 'Lato',
                    fontSize: 13
                  )
                ),
                Padding(padding: EdgeInsets.only(bottom: 7)),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber.shade400, size: 20),
                    SizedBox(width: 5),
                    Text('${movie.voteAverage}', 
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 13
                      )
                    )
                  ]
                )
              ]
            )
          ),
        ]
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  final Movie movie;
  const _Overview(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontFamily: 'Lato',
          fontSize: 17
        ),
      )
    );
  }
}