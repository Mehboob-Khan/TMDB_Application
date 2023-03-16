import 'package:flutter/material.dart';
import 'package:tmdb_application/Screens/movie_screen.dart';

import '../constant/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // creatimg a page controller
    PageController _controller = PageController();
    void onTapIcon(int index) {
      _controller.animateToPage(index,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    }

    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(_currentIndex),
      ),
      body: PageView(
        controller: _controller,
        children: const <Widget>[
          MovieScreen(),
          
          Center(
            child: Text('Watch list', style: TextStyle(color: Style.textColor)),
          ),
        ],
        onPageChanged: (value) => setState(() {
          _currentIndex = value;
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Style.primaryColor,
        selectedItemColor: Style.secondColor,
        unselectedItemColor: Style.textColor,
        onTap: onTapIcon,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Watchlist',
          ),
        ],
      ),
    );
  }

  _buildTitle(int _index) {
    switch (_index) {
      case 0:
        return const Text('Movie Shows');
      case 1:
        return const Text('Watchlist');
      default:
        return null;
    }
  }
}