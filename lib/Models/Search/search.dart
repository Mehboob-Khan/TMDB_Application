import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'SearchModel.dart';
import 'package:tmdb_application/Models/Search/searchbarw.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String current = "movie";
  String query = "";
  String sortOrder = "popularity.desc";
  List results = [];

  void debounce(VoidCallback callback, Duration delay) {
    Timer? debounceTimer;
    if (debounceTimer != null) {
      debounceTimer.cancel();
    }
    debounceTimer = Timer(delay, callback);
  }

  void updateSortOrder(String? newSortOrder) {
    if (newSortOrder != null) {
      setState(() {
        sortOrder = newSortOrder;
      });
      search();
    }
  }

  void search() async {
    setState(() {
      results = [];
    });
    if (kDebugMode) {
      print('$query $current');
    }

    String url = '';

    if (query.isEmpty) {
      url =
          'https://api.themoviedb.org/3/discover/$current?api_key=6458ca648b70d6d3d574f8e0b2ce817d&language=en-US&sort_by=$sortOrder';
    } else {
      url =
          'https://api.themoviedb.org/3/search/$current?api_key=6458ca648b70d6d3d574f8e0b2ce817d&language=en-US&query=$query';
    }

    url += '&append_to_response=credits';
    if (kDebugMode) {
      print(url);
    }

    try {
      var response = await http.get(Uri.parse(url));
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        results = jsonResponse['results'];
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        backgroundColor: Colors.black,
        actions: <Widget>[
          DropdownButton<String>(
            value: sortOrder,
            icon: const Icon(Icons.sort),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Colors.white,
            ),
            onChanged: updateSortOrder,
            items: <String>[
              'popularity.desc',
              'popularity.asc',
              'vote_average.desc',
              'vote_average.asc',
              'primary_release_date.asc',
              'primary_release_date.desc',
            ].map<DropdownMenuItem<String>>((String value) {
              String displayText;
              switch (value) {
                case 'popularity.desc':
                  displayText = 'Most Popular';
                  break;
                case 'popularity.asc':
                  displayText = 'Least Popular';
                  break;
                case 'vote_average.desc':
                  displayText = 'Highest Rated';
                  break;
                case 'vote_average.asc':
                  displayText = 'Lowest Rated';
                  break;
                case 'primary_release_date.asc':
                  displayText = 'Oldest';
                  break;
                case 'primary_release_date.desc':
                  displayText = 'Latest';
                  break;
                default:
                  displayText = value;
              }
              return DropdownMenuItem<String>(
                value: value,
                child: Text(displayText),
              );
            }).toList(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(Icons.search),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          onChanged: (val) {
                            setState(() {
                              query = val;
                            });
                            debounce(search, const Duration(milliseconds: 500));
                          },
                          onEditingComplete: search,
                          decoration: const InputDecoration(
                              hintText: "What would you like to watch?",
                              border: InputBorder.none),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 150, // Set a fixed height for the SearchCard
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchModel(
                              id: results[index]['id'],
                            ),
                          ),
                        );
                      },
                      child: SearchCard(
                        imageUrl: results[index]['poster_path'] ?? '',
                        language: results[index]['original_language'] ?? '',
                        releaseDate: results[index]['release_date'] ?? '',
                        title: results[index]['original_title'] ?? '',
                        votes: (results[index]['vote_average'] ?? 0).toString(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
