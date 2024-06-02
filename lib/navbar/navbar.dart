import 'package:flutter/material.dart';
import 'navbar_buttons.dart';
import '../user.dart';

class NavBar extends StatelessWidget {
  final User user;
  const NavBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Color.fromARGB(117, 0, 0, 0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          NavigationButton(
            buttonName: 'Home',
            user: user,
          ),
          NavigationButton(
            buttonName: 'Search',
            user: user,
          ),
          NavigationButton(
            buttonName: 'Your library',
            user: user,
          ),
          Container(
            color: Color.fromARGB(117, 0, 0, 0),
            height: 20,
          ),
          NavigationButton(
            buttonName: 'Create Playlist',
            user: user,
          ),
          NavigationButton(
            buttonName: 'Liked Songs',
            user: user,
          )
        ],
      ),
    );
  }
}
