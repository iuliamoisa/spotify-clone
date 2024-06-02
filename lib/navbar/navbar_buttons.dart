// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import '../user.dart';
import '../home/home.dart';
import '../playlist_screen/playlist_page.dart';
import '../playlist.dart';
class NavigationButton extends StatelessWidget {
  String buttonName;
  User user;
  NavigationButton({super.key, required this.buttonName, required this.user});

  IconData matchButtonIcon() {
    if (buttonName == 'Home') {
      return Icons.home;
    } else if (buttonName == 'Search') {
      return Icons.search;
    } else if (buttonName == 'Create Playlist') {
      return Icons.add;
    } else if (buttonName == 'Liked Songs') {
      return Icons.favorite;
    }
    return Icons.library_music;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox( 
      width: 250,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(90, 0, 0, 0), 
            padding: EdgeInsets.all(10)),
        onPressed: () {
          if (buttonName == "Home") {
            Navigator.push(context, MaterialPageRoute(builder: (builder) {
              return Home(user: user);
            }));
          } else if (buttonName == "Liked Songs") {
            Navigator.push(context, MaterialPageRoute(builder: (builder) {
              return PlaylistPage(
                playlist: Playlist({
                  "id": 0,
                  "name": "Liked Songs",
                  "description": "",
                  "type": "uniquely_yours",
                  "owner": "user",
                  "likes": 1,
                  "clicks": 100,
                  "songs": user.likedSongs,
                  "imageUrl": "https://i.scdn.co/image/ab67706c0000da8470d229cb865e8d81cdce0889"
                }),
                user: user,
              );
            }));
          }
        },
        child: SizedBox(
          width: double.infinity,
          child: Wrap(
            spacing: 10,
            children: [
              Icon(matchButtonIcon(), color: Colors.white,),
              Text(buttonName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 15,
                      color: Colors.white,
                      letterSpacing: 1.0),)
            ],
          ),
        ),
      ),
    );
  }
}
