import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:pelitoday/models/models.dart';

class CardSwipper extends StatelessWidget {
  final List<Movie> movies;
  final String title;

  const CardSwipper({
    Key? key,
    required this.movies,
    required this.title
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if(this.movies.length == 0) {
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(child: CircularProgressIndicator())
      );
    }

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      margin: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            title, 
            style: TextStyle(
              fontSize: 20, 
              fontWeight: FontWeight.bold, 
              fontFamily: 'Lato'
            )
          ),
          SizedBox(height: 15),
          Swiper(
            itemCount: movies.length,
            layout: SwiperLayout.STACK,
            itemWidth: size.width * 0.7,
            itemHeight: size.height * 0.4,
            itemBuilder: (BuildContext _, int index) {
              final movie = movies[index];
              movie.heroId = 'swipper-${movie.id}';
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
                child: Hero(
                  tag: movie.heroId!,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage(
                      placeholder: AssetImage('assets/loading.gif'), 
                      image: NetworkImage(movie.fullPosterImg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}