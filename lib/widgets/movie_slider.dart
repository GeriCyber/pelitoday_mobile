import 'package:flutter/material.dart';
import 'package:pelitoday/models/models.dart';

class MovieSlider extends StatelessWidget {

  final List<Movie> movies;
  final String? title;

  const MovieSlider({
      Key? key, 
      required this.movies, 
      this.title
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(this.title != null) 
              Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(this.title!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
              ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (_, index) => _MoviePoster(movies[index]),
              ),
            )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  final Movie movie;
  const _MoviePoster(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 260,
      margin: EdgeInsets.symmetric(horizontal: 10), 
      child: Column(
        children: [
    
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details', arguments: 'Star Wars: The Last Jedi'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FadeInImage(
                  image: NetworkImage(this.movie.fullPosterImg),
                  placeholder: AssetImage('assets/loading.gif'),
                  height: 190,
                  width: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 5),

            Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
        
        ]
      )
    );
  }
}