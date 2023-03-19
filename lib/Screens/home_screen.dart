import 'package:flutter/material.dart';
import 'package:tmdb_application/Screens/movie_screen.dart';
import 'package:tmdb_application/firebase/profile.dart';
import 'package:provider/provider.dart';
import '../Models/Search/search.dart';
import '../constant/style.dart';
import '../firebase/UserinfoProvider.dart';
import '../movie_widgets/movie_watchlist_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    void onTapIcon(int index) {
      _controller.animateToPage(index,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    }

    return Scaffold(
      appBar: _currentIndex != 3
          ? AppBar(
              title: _buildTitle(_currentIndex),
            )
          : null,
      body: PageView(
        controller: _controller,
        children: <Widget>[
          const MovieScreen(),
          const MovieWatchLists(),
          Search(),
          //CinemasPage(), // Add this line for the nearby theaters screen
          ChangeNotifierProvider(
            create: (context) => UserInfoProvider(),
            child: Profile(),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.theaters), // Update the icon here
            label: 'Nearby Theaters', // Update the label here
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget? _buildTitle(int _index) {
    switch (_index) {
      case 0:
        return const Text('Movie Shows');
      case 1:
        return null;
      case 2:
        return const Text('Search Bar');
      case 3:
        return const Text('Nearby Theaters'); // Update this line
      case 4:
        return const Text('Profile');
      default:
        return null;
    }
  }
}
