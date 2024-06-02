import 'package:flutter/material.dart';
import '../playlist.dart';
import '../user.dart';
import '../navbar/android_navbar.dart';
import '../song.dart';
import 'components/song_progress_indicator.dart';
import 'dart:math';

class AndroidSongPage extends StatefulWidget {
  final Playlist playlist;
  final User user;
  final Song song;

  AndroidSongPage({required this.playlist, required this.user, required this.song});

  @override
  _AndroidSongPageState createState() => _AndroidSongPageState();
}

class _AndroidSongPageState extends State<AndroidSongPage> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    // Check if the current song is liked by the user
    isLiked = widget.user.likedSongs.contains(widget.song.songId);
  }

  void toggleLike() {
    setState(() {
      // Toggle the liked status
      isLiked = !isLiked;
      if (isLiked) {
        widget.user.likedSongs.add(widget.song.songId);
      } else {
        widget.user.likedSongs.remove(widget.song.songId);
      }
    });
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
        bottomNavigationBar: AndroidNavBar(user: widget.user),
      ),
    );
  }

  Widget createSongPageBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: [
          SizedBox(height: 25),
          createHeader(context),
          createSongImage(context),
          createSongInfo(context),
          ProgressIndicatorExample(
            song: widget.song,
          ),
        ],
      ),
    );
  }

  Widget createLikeButton() {
    return IconButton(
      icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
      tooltip: 'Add to favourites',
      onPressed: toggleLike,
    );
  }

  Widget createSongInfo(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.song.title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                widget.song.artist,
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
        createLikeButton(),
      ],
    );
  }

  Widget createSongImage(BuildContext context) {
    // Generate a random color
    Color randomColor = Color.fromRGBO(
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
      1.0,
    );

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
          color: randomColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

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
              SizedBox(height: 2),
              Text(
                widget.playlist.name,
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
}
