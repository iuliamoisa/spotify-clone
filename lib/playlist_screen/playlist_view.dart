// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:spotify/platform.dart';
import 'components/playlist_info.dart';
import 'components/song_list.dart';
import '../playlist.dart';
import '../song.dart';
import '../user.dart';

class PlaylistView extends StatelessWidget {
  Playlist playlist;
  User user;
  PlaylistView({required this.playlist, required this.user});

List<Song> createSongList() {
  List<Song> songs = [];
  for (var songId in playlist.songs) {
    // Creează un obiect Map pentru datele cântecului
    Map<String, dynamic> songData = {
      'songId': songId,
      'title': 'Song Title', // Titlul cântecului poate fi inițializat cu o valoare implicită
      'artist': 'Artist Name', // Artistul cântecului poate fi inițializat cu o valoare implicită
      'album': 'Album Name', // Albumul cântecului poate fi inițializat cu o valoare implicită
      'length': 0.0, // Lungimea cântecului poate fi inițializată cu o valoare implicită
    };
    songs.add(Song(songData)); // Inițializează un obiect Song folosind datele create
  }
  return songs;
}


  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            color: const Color.fromRGBO(26, 26, 26, 1),
            height: MediaQuery.of(context).size.height,
            width: isWeb() ? null : MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  PlaylistInfo(
                    playlist: playlist,
                  ),
                  SongList(
                    playlist: playlist,
                    user: user,
                  ),
                ]))));
  }
}
