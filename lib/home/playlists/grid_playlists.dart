import 'package:flutter/material.dart';
import 'small_playlist.dart';
import '../../playlist.dart';
import '../../platform.dart';
import '../../user.dart';

class GridPlaylists extends StatelessWidget {
  final List playlists;
  final User user;
  GridPlaylists({super.key, required this.playlists, required this.user});

  double setHorizontalSpacing() {
    return isWeb() ? 10 : 10;
  }

  double setVerticalSpacing() {
    return isWeb() ? 20 : 35;
  }

  Widget createShortRow(Playlist playlist1, Playlist playlist2) {
    return Row(
      children: [
        SmallPlaylist(
          playlist: playlist1,
          user: user,
        ),
        Container(
          width: setVerticalSpacing(),
        ),
        SmallPlaylist(
          playlist: playlist2,
          user: user,
        )
      ],
    );
  }

  Widget createLongRow(
      Playlist playlist1, Playlist playlist2, Playlist playlist3) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmallPlaylist(
          playlist: playlist1,
          user: user,
        ),
        Container(
          width: 20,
        ),
        SmallPlaylist(
          playlist: playlist2,
          user: user,
        ),
        Container(
          width: 20,
        ),
        SmallPlaylist(
          playlist: playlist3,
          user: user,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 1250) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: createShortRow(
                    Playlist(playlists[0]), Playlist(playlists[1])),
              ),
              Container(
                height: setHorizontalSpacing(),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: createShortRow(
                    Playlist(playlists[2]), Playlist(playlists[3])),
              ),
              Container(
                height: setHorizontalSpacing(),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: createShortRow(
                    Playlist(playlists[4]), Playlist(playlists[5])),
              ),
            ]),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: createLongRow(Playlist(playlists[0]), Playlist(playlists[1]),
                Playlist(playlists[2]))),
        Container(
          height: 20,
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: createLongRow(Playlist(playlists[3]), Playlist(playlists[4]),
                Playlist(playlists[5]))),
      ]),
    );
  }
}
