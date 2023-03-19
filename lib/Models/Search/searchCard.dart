import 'package:flutter/material.dart';

import 'custome_cached_image.dart';

class SearchCard extends StatelessWidget {
  final String imageUrl;
  final String language;
  final String releaseDate;
  final String title;
  final String votes;

  const SearchCard({
    Key? key,
    required this.imageUrl,
    required this.language,
    required this.releaseDate,
    required this.title,
    required this.votes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          imageUrl.isNotEmpty
    ? CustomCachedImage(
  imageUrl: 'https://image.tmdb.org/t/p/w200$imageUrl',
  width: 100,
  height: 150,
)
    : Image.asset(
        'assets/images/notfound.png',
        width: 100,
        height: 150,
        fit: BoxFit.cover,
      ),

          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title.isNotEmpty ? title : "N/A",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Language : " + (language.isNotEmpty ? (language == "en" ? "English" : language) : "N/A"),
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Average Vote : ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 16,
                        ),
                        Text(
                          votes,
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Release Date : " + (releaseDate.isNotEmpty ? releaseDate : "N/A"),
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
