import"package:flutter/material.dart";
import "package:map_project/speed%20.dart";

import "map.dart";

int _currentIndex = 0;
List<Widget> _children = [
  const MyApp(),
  const Speed(),
];
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(

        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.speed),
            label: 'Speed',
          ),
        ],
      )
    );
  }
}
