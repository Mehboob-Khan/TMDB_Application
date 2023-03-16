import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import '../Models/Movie/movie_model.dart';
import '../http/http_request.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: FutureBuilder<MovieModel>(
        future: HttpRequest.getMovies("popular"),
        builder: (BuildContext context, AsyncSnapshot<MovieModel> snapshot) {
          if (snapshot.hasData) {
            return _buildContentWidget(snapshot.data);
          }
          return Container();
        },
      ),
    );
  }
  Widget _buildContentWidget(MovieModel? movies) {
    return Container(
      child: Center(
        child: Text("${movies!.movies![0].title}"),
      ),
    );
  }
}
