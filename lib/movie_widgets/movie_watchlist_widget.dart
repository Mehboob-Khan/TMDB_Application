import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Models/Movie/hive_movie_model.dart';
import '../Models/Movie/movie_model.dart';
import '../Screens/movie_details_screen.dart';
import '../constant/style.dart';

class MovieWatchLists extends StatefulWidget {
  const MovieWatchLists({Key? key}) : super(key: key);

  @override
  State<MovieWatchLists> createState() => _MovieWatchListsState();
}

class _MovieWatchListsState extends State<MovieWatchLists> {
  late Box<HiveMovieModel> _movieWatchLists;

  @override
  void initState() {
    _movieWatchLists = Hive.box<HiveMovieModel>('movie_lists');
    super.initState();
  }

  Widget build(BuildContext context) {
    return SizedBox(
      child: _movieWatchLists.isEmpty
          ? const Center(
              child: Text(
                "No Movies added to list yet!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Style.textColor,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ValueListenableBuilder(
                    valueListenable: _movieWatchLists.listenable(),
                    builder: (context, Box<HiveMovieModel> item, _) {
                      List<int> keys = item.keys.cast<int>().toList();
                      return ListView.builder(
                        itemCount: keys.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final key = keys[index];
                          final HiveMovieModel? _item = item.get(key);
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              title: Text(_item!.title),
                              subtitle: Text(
                                _item.overview,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: Image.network(
                                "https://image.tmdb.org/t/p/w500${_item.poster}",
                                fit: BoxFit.cover,
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    _movieWatchLists.delete(key);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
