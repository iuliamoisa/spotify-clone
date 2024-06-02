import 'package:flutter/material.dart';
import '../playlist.dart';
import '../user.dart';
import '../song.dart';
import 'components/song_progress_indicator.dart';

class WebSongPage extends StatefulWidget {
  final Playlist playlist;
  final User user;
  final Song song;

  WebSongPage({required this.playlist, required this.user, required this.song});

  @override
  _WebSongPageState createState() => _WebSongPageState();
}

class _WebSongPageState extends State<WebSongPage> {
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
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(26, 26, 26, 1),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: createSongPageBody(context),
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
          IconButton(
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: Color.fromARGB(255, 255, 255, 255),
              size: 20,
            ),
            tooltip: 'Add to favourites',
            onPressed: toggleLike,
          ),
        ],
      ),
    );
  }

  Widget createSongInfo(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.song.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  widget.song.artist,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
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
}
