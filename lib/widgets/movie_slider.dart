import 'package:flutter/material.dart';

class MovieSlider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Popular', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (_, index) => _MoviePoster(),
            ),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

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
                  image: NetworkImage('https://via.placeholder.com/300x400'),
                  placeholder: AssetImage('assets/loading.gif'),
                  height: 190,
                  width: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 5,),

            Text(
              'Movie Title',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
        
        ]
      )
    );
  }
}