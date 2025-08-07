import 'package:flutter/material.dart';
import 'package:litz/Admin%20Pannel/points.dart';
import 'package:litz/Homepage/home.dart';
import 'package:litz/Incentive/Incentive.dart';
import 'package:litz/Profile/Profile.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  int _currentIndex = 0;
  Widget build(BuildContext context) {
    final List<Widget> _pages = [Home(), PointsScreen(), Points(), Profile()];
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, 
        onTap: (index) {
          setState(() {
            _currentIndex = index; 
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Incentives',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.poll_outlined),
            label: 'Points',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
