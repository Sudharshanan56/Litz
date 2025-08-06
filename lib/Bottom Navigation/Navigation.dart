import 'package:flutter/material.dart';
import 'package:litz/Homepage/home.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  int _currentIndex = 0;
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      Home(),
      Text('page 2'),
      Text('page 3'),
      Text('page 4'),
    ];
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // current tab index
        onTap: (index) {
          setState(() {
            _currentIndex = index; // switch tab
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
