import 'package:flutter/material.dart';
import 'package:super_comics_app/screens/search_heroes.dart';
import 'package:super_comics_app/screens/favorite_heroes.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedTab = 0;
  final imageURL =
      "https://pe.salvat.com/dccollection/res/img/main-content-heroes.png";

  final List<Widget> _children = [
    const SearchHeroes(),
    const FavoriteHeroes(),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.network(
                  imageURL,
                  height: 150,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Super Comics App',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
          Expanded(
            child: _children[_selectedTab],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
