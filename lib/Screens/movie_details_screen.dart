import 'package:flutter/material.dart';

import '../Models/Movie/movie_model.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title, 
        overflow: TextOverflow.ellipsis,),
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage
                  (
                    image: NetworkImage('https://image.tmdb.org/t/p/original/'+widget.movie.backDrop!),
                  )
                ),
              ),
            ],
          ), 
        ],
      ),
    );
  }
}