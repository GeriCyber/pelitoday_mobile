import 'package:flutter/material.dart';
import 'package:pelitoday/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  
    // TODO: Change later for a real movie instance
    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(delegate: SliverChildListDelegate([
            _PosterAndTitle(),
            _Overview(),
            _Overview(),
            _Overview(),
            CastingCards()
          ]))
        ]
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 5),
          color: Colors.black12,
          child: Text(
            'movie.title',
            style: TextStyle(fontSize: 16)
          ),
        ),

        background: FadeInImage(
          image: NetworkImage('https://via.placeholder.com/500x300'),
          placeholder: AssetImage('assets/loading.gif'),
          fit: BoxFit.cover,
        )
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              image: NetworkImage('https://via.placeholder.com/230x300'),
              placeholder: AssetImage('assets/loading.gif'),
              height: 150,
              width: 115,
            )
          ),

          SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'movie.title',
                style: Theme.of(context).textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2,
              ),
              Text(
                'movie.originaltitle',
                style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis,
              ),

              Row(
                children: [
                  Icon(Icons.star_outline, color: Colors.grey, size: 20),
                  SizedBox(width: 5),
                  Text('movie.voteAverage', style: Theme.of(context).textTheme.caption)
                ]
              )
            ]
          )
        ]
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text('lorem ipsum lorem ipsum lorem ipsum lorem ipsum',
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.subtitle1,
      )
    );
  }
}