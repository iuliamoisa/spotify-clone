import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../navbar/android_navbar.dart';
import '../user.dart';
import '../playlist.dart';
import '../left_side_pannel.dart'; // Import pentru bara laterală
import 'dart:convert';
import '../platform.dart';

class LibraryPage extends StatefulWidget {
  final User user;
  const LibraryPage({super.key, required this.user});

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  Future<List<Playlist>>? _userPlaylists;

  @override
  void initState() {
    super.initState();
    _userPlaylists = getUserPlaylists();
  }

  Future<List<Playlist>> getUserPlaylists() async {
    final String response = await rootBundle.loadString('assets/playlists.json');
    final data = await json.decode(response);
    List users = data['users'];

    for (var user in users) {
      if (user['userId'] == widget.user.id) {
        List<Playlist> playlists = List<Playlist>.from(
            user['playlists'].map((playlist) => Playlist(playlist)));
        return playlists;
      }
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isWeb()
          ? Row(
              children: [
                LeftSidePannel(user: widget.user), // Bara laterală pentru web
                Expanded(
                  child: buildLibraryBody(isWeb: true),
                ),
              ],
            )
          : buildLibraryBody(), // Pe dispozitive mobile, afișează direct corpul bibliotecii
      bottomNavigationBar: isWeb()
          ? null // Pe web, nu afișa bara de navigare de jos
          : AndroidNavBar(user: widget.user), // Pe dispozitive mobile, folosește bara de navigare Android
    );
  }

  Widget buildLibraryBody({bool isWeb = false}) {
    return Container(
      color: Color.fromRGBO(26, 26, 26, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Your Library',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Playlist>>(
              future: _userPlaylists,
              builder: (BuildContext context, AsyncSnapshot<List<Playlist>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No playlists found'));
                } else {
                  return GridView.builder(
                    padding: EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isWeb ? 3 : 2, // Pe web afișează 3 categorii pe linie, altfel 2
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final playlist = snapshot.data![index];
                      return PlaylistCard(playlist: playlist);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

}

class PlaylistCard extends StatelessWidget {
  final Playlist playlist;

  const PlaylistCard({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(playlist.imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              playlist.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              playlist.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
