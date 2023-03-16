import 'package:flutter/material.dart';

import '../constant/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController();
    void _onPageChanged(int index) {
      setState(() {
        _currentIndex = index;
      });
      _pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    }

    return Scaffold(
      appBar: AppBar(title: _buildTitle(_currentIndex)),
      body: PageView(
        controller: _pageController, 
        children: const <Widget>[
          HomeScreen(),
          Center(child: Text('Favorite')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Style.primaryColor,
        selectedItemColor: Style.secondColor,
        unselectedItemColor: Style.textColor,
        onTap: _onPageChanged,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
        ],
      ),
    );
  }

  _buildTitle(int index)
  {
    switch (index) {
      case 0:
        return const Text('Movie Shows');
      case 1:
        return const Text('Favorite');
      default:
        return null;
    }
  }
}
