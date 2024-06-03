import 'package:flutter/material.dart';
import 'package:spotify/search_page.dart';
import 'package:spotify/library_page.dart';
import '../user.dart';
import '../home/home.dart';

class AndroidNavBar extends StatelessWidget {
  final User user;
  const AndroidNavBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting, // Shifting
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_music),
          label: 'Your Library',
          backgroundColor: Colors.black,
        ),
      ],
      onTap: (value) {
        switch (value) {
          case 0:
            Navigator.push(context, MaterialPageRoute(builder: (builder) {
              return Home(user: user);
            }));
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (builder) {
              return SearchPage(user: user); // Inlocuieste cu pagina ta de cautare
            }));
          case 2:
            Navigator.push(context, MaterialPageRoute(builder: (builder) {
              return LibraryPage(user: user); // Inlocuieste cu pagina ta de biblioteca
            }));
        }
      },
    );
  }
}
