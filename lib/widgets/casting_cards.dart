import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pelitoday/models/models.dart';
import 'package:pelitoday/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {

  final int movieId;
  const CastingCards(this.movieId);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if(!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;

        if(cast.isNotEmpty) {
          return Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 20, top: 10),
                child: Text('Cast',
                  style: TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold, 
                    fontFamily: 'Lato'
                  )
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30.0, top: 10.0),
                width: double.infinity,
                height: 180,
                child: ListView.builder(
                  itemCount: cast.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) => _CastCard(cast[index])
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

class _CastCard extends StatelessWidget {

  final Cast actor;
  const _CastCard(this.actor);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 180,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              image: NetworkImage(actor.fullProfileImg),
              placeholder: AssetImage('assets/loading.gif'),
              height: 140,
              width: 100,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 5),
          Text(actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 12
            ),
          ),
        ]
      ),
    );
  }
}