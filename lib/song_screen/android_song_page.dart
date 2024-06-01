import 'package:flutter/material.dart';
import '../playlist.dart';
import '../user.dart';
import '../navbar/android_navbar.dart';
import '../song.dart';
import 'components/song_progress_indicator.dart';

class AndroidSongPage extends StatelessWidget {
  final Playlist playlist;
  final User user;
  final Song song;

  AndroidSongPage({required this.playlist, required this.user, required this.song});

  Widget createHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 35),
          ),
          const Spacer(),
          Column(
            children: [
              const Text(
                "PLAYING FROM YOUR LIBRARY",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
              SizedBox(height: 2), // Replaced Container with SizedBox
              Text(
                playlist.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.more_vert, color: Colors.white),
        ],
      ),
    );
  }

  bool isLiked(int id) {
    return user.likedSongs.contains(id.toString());
  }

  IconData getIcon(int id) {
    return isLiked(id) ? Icons.favorite : Icons.favorite_border;
  }

  Widget createLikeButton(int id) {
    return IconButton(
      icon: Icon(getIcon(id)),
      tooltip: 'Add to favourites',
      onPressed: () {
        if (isLiked(id)) {
          user.likedSongs.remove(id.toString());
        } else {
          user.likedSongs.add(id.toString());
        }
      },
    );
  }

  Widget createSongInfo(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 250, // Replaced Container with SizedBox
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                song.title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5), // Replaced Container with SizedBox
              Text(
                song.artist,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        createLikeButton(song.songId),
      ],
    );
  }

  Widget createSongImage(BuildContext context) {
    return SizedBox(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: Container(
        color: Colors.black,
      ),
    );
  }

  Widget createSongPageBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: [
          SizedBox(height: 25), // Replaced Container with SizedBox
          createHeader(context),
          createSongImage(context),
          createSongInfo(context),
          ProgressIndicatorExample(
            song: song,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: const Color.fromRGBO(26, 26, 26, 1),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: createSongPageBody(context),
        ),
        bottomNavigationBar: AndroidNavBar(user: user),
      ),
    );
  }
}
