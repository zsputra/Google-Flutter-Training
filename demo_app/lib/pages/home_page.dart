import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  final List<Widget> _drawersMenu = [
    AppBar(
      // leading: IconButton(icon: Icon(Icons.child_care), tooltip: 'Menu', onPressed: (){},),
      automaticallyImplyLeading: false,
      title: Text('Drawer'),
    ),
    ListTile(
      title: Text('Dashboard'),
      onTap: () {},
    ),
    ListTile(
      title: Text('Search'),
      onTap: () {},
    ),
    ListTile(
      title: Text('Favorite'),
      onTap: () {},
    ),
    ListTile(
      title: Text('Settings'),
      onTap: () {},
    )
  ];


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(children: _drawersMenu),
      ),
      appBar: AppBar(
        title: Text("Home"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            // backgroundColor: Colors.deepOrange,
            icon: Icon(Icons.dashboard),
            title: Text('Dashboard'),
          ),
          BottomNavigationBarItem(
            // backgroundColor: Colors.deepOrange,
            icon:  Icon(Icons.search),
            title: Text("Search", style: TextStyle(color: Colors.deepOrange),),
          ),
          BottomNavigationBarItem(
              // backgroundColor: Colors.deepOrange,
              icon: Icon(Icons.favorite, color: Colors.pinkAccent,), 
              title: Text('Favorite', style: TextStyle(color: Colors.deepOrange),)),
          BottomNavigationBarItem(
              // backgroundColor: Colors.deepOrange,
              icon: Icon(Icons.settings), title: Text('Settings', style: TextStyle(color: Colors.deepOrange),))
        ],
      ),
    );
  }
}
