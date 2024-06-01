import 'package:flutter/material.dart';
import 'navbar/navbar.dart';
import 'playlist_button.dart';
import 'user.dart';
import 'playlist.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class LeftSidePannel extends StatefulWidget {
  final User user;
  const LeftSidePannel({super.key, required this.user});

  @override
  State<LeftSidePannel> createState() => _LeftSidePannelState();
}

class _LeftSidePannelState extends State<LeftSidePannel> {
  Future<List<Playlist>>? _userPlaylists;
  Playlist? _selectedPlaylist;

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

  void _selectPlaylist(Playlist? playlist) {
    setState(() {
      _selectedPlaylist = playlist;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: 15),
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          NavBar(user: widget.user),
          Divider(color: const Color.fromARGB(140, 158, 158, 158), height: 0.1),
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
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return PlaylistButton(
                        playlist: snapshot.data![index],
                        user: widget.user,
                        isSelected: _selectedPlaylist == snapshot.data![index],
                        onSelect: _selectPlaylist,
                      );
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
