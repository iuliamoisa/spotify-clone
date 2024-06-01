import 'package:flutter/material.dart';
import '../playlist.dart';
import '../user.dart';
import 'playlist_view.dart';
import '../platform.dart';
import '../navbar/android_navbar.dart';
import '../left_side_pannel.dart';

class PlaylistPage extends StatelessWidget {
  final Playlist playlist;
  final User user;
  PlaylistPage({required this.playlist, required this.user});

  Widget createPlaylistPage() {
    var components = isWeb()
        ? [
            LeftSidePannel(
              user: user,
            ),
            PlaylistView(
              playlist: playlist,
              user: user,
            )
          ]
        : [
            PlaylistView(
              playlist: playlist,
              user: user,
            )
          ];

    return isWeb()
        ? SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(child: Row(children: components)))
        : PlaylistView(
            playlist: playlist,
            user: user,
          );
  }

  @override
  Widget build(BuildContext context) {
    return isWeb()
        ? MaterialApp(home: Scaffold(body: createPlaylistPage()))
        : MaterialApp(
            home: Scaffold(
            body: Column(children: [
              createPlaylistPage(),
            ]),
            bottomNavigationBar: AndroidNavBar(user: user),
          ));
  }
}
