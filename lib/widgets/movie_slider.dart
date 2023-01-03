import 'package:flutter/material.dart';
import 'package:pelitoday/models/models.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({
      Key? key, 
      required this.movies, 
      required this.onNextPage,
      this.title, 
    }) : super(key: key);

  @override
  _MovieSliderState createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500) {
        this.widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(this.widget.title != null) 
              Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(this.widget.title!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
              ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.movies.length,
                itemBuilder: (_, index) => _MoviePoster(widget.movies[index], '${widget.title}-$index-${widget.movies[index].id}'),
              ),
            )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  final Movie movie;
  final String heroId;
  const _MoviePoster(this.movie, this.heroId);

  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;
    return Container(
      width: 150,
      height: 260,
      margin: EdgeInsets.symmetric(horizontal: 10), 
      child: Column(
        children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
              child: Hero(
                tag: movie.heroId!,
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