import 'package:flutter/material.dart';
import 'package:spotify/home/home.dart';
import '../user.dart';
import '../search_page.dart'; // Importăm pagina de căutare
import '../library_page.dart'; // Importăm pagina de bibliotecă

class NavigationButton extends StatelessWidget {
  final String buttonName;
  final User user;
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
          if (buttonName == "Search") {
            Navigator.push(context, MaterialPageRoute(builder: (builder) {
              return SearchPage(user: user);
            }));
          } else if (buttonName == 'Your library') {
            Navigator.push(context, MaterialPageRoute(builder: (builder) {
              return LibraryPage(user: user);
            }));
          }
          else if (buttonName == "Home") {
            Navigator.push(context, MaterialPageRoute(builder: (builder) {
              return Home(user: user);
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
