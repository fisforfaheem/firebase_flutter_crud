import 'package:firebase_flutter_crud/presentation/add_user.dart';
import 'package:firebase_flutter_crud/presentation/read_data_display.dart';
import 'package:firebase_flutter_crud/presentation/view_all_users.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    AddUser(),
    ReadAndDisplayUserData(),
    ViewAllUsers(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2),
            label: 'Add User',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search User',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'View All Users',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
