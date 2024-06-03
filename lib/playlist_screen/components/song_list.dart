// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:spotify/playlist.dart';
import 'package:spotify/song_screen/web_song_page.dart';
import '../../song.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../../user.dart';
import '../../platform.dart';
import '../../song_screen/android_song_page.dart';

class SongList extends StatefulWidget {
  Playlist playlist;
  User user;
  SongList({required this.playlist, required this.user});

  @override
  SongListState createState() => SongListState();
}

class SongListState extends State<SongList> {
 Future<List<Map<String, dynamic>>> getSongs() async {
  List<Map<String, dynamic>> playlistSongs = [];
  final String response = await rootBundle.loadString('assets/songs.json');
  final data = await json.decode(response);
  List songs = data['songs'];

  for (var song in songs) {
    if (widget.playlist.songs.contains(song['songId'])) {
      playlistSongs.add(song);
    }
  }
  return playlistSongs;
}


  Future updateLikedSongs(int userId, int songId) async {
    final String response = await rootBundle.loadString('assets/users.json');
    dynamic data = await json.decode(response);
    setState(() {
      List users = data['users'];
      for (var crtUser in users) {
        if (crtUser['id'] == userId) {
          List likedSongs = crtUser['likedSongs'];
          likedSongs.add(songId);
          widget.user.likedSongs = likedSongs;
          crtUser['likedSongs'] = likedSongs;
        }
        data['users'] = users;
      }
    });
  }

  bool isLiked(int id) {
    return widget.user.likedSongs.contains(id);
  }

  Widget getIcon(int id) {
    IconData icon = isLiked(id) ? Icons.favorite : Icons.favorite_border;
    return Icon(icon, color: Color.fromARGB(255, 255, 255, 255), size: 20);
  }

  Widget createHeader() {
    return isWeb()
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                createIndex("#"),
                createInfo("Title", 6),
                createInfo("Album", 4),
                createInfo("Date added", 4),
                Expanded(
                    flex: 2,
                    child: Column(children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: const Icon(
                            Icons.schedule,
                            color: Colors.grey,
                            size: 20,
                          ))
                    ])),
              ])
        : Row(
            children: [
              const Icon(Icons.auto_awesome_sharp,
                  color: Colors.white, size: 30),
              Container(
                width: 20,
              ),
              const Icon(Icons.download_for_offline_outlined,
                  color: Colors.white, size: 30),
              Container(
                width: 20,
              ),
              const Icon(Icons.person_add_outlined,
                  color: Colors.white, size: 30),
              Container(
                width: 20,
              ),
              const Icon(Icons.more_vert, color: Colors.white, size: 30),
              const Spacer(),
              const Icon(Icons.shuffle, color: Colors.white, size: 30),
              Container(
                width: 20,
              ),
              const Icon(Icons.play_circle, color: Colors.blue, size: 60),
            ],
          );
  }

  Widget createLikeButton(int id) {
    return IconButton(
      icon: getIcon(id),
      tooltip: 'Add to favourites',
      onPressed: () {
        setState(() {
          if (isLiked(id)) {
            widget.user.likedSongs.remove(id);
          } else {
            widget.user.likedSongs.add(id);
          }
        });
      },
    );
  }

  Widget createTime(String duration, int id) {
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [createLikeButton(id), createInfo(duration, 4)],
      ),
    );
  }

  Widget createIndex(String index) {
    return SizedBox(
      width: 25,
      child: Text(index,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey)),
    );
  }

  Widget createInfo(String info, int flexValue) {
    return Expanded(
      flex: flexValue,
      child: Padding(
          padding: const EdgeInsets.only(right: 3, top: 3),
          child: Text(info,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.grey))),
    );
  }

  Widget createSongTitle(String title, String artist) {
    return Expanded(
        flex: 6,
        child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white)),
                Text(artist,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.grey))
              ],
            )));
  }

  Widget createSongEntry(int index, Map<String, dynamic> songData) {
  Song song = Song(songData);
  String dateAdded = songData['dateAdded']; // Assume that dateAdded is in the JSON

  return isWeb()
      ? GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return WebSongPage(
                  user: widget.user, playlist: widget.playlist, song: song);
            }));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              createIndex(index.toString()),
              createSongTitle(song.title, song.artist),
              createInfo(song.album, 4),
              createInfo(dateAdded, 4), // Display the actual date added
              createTime(song.length.toString(), song.songId),
            ],
          ),
        )
      : Row(
          children: [
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) {
                    return AndroidSongPage(
                        user: widget.user,
                        playlist: widget.playlist,
                        song: song);
                  }));
                },
                child: SizedBox(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          song.title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white),
                        ),
                        Container(
                          height: 5,
                        ),
                        Text(
                          song.artist,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.grey),
                        )
                      ],
                    ))),
            const Spacer(),
            createLikeButton(song.songId),
            const Icon(Icons.more_vert, color: Colors.white, size: 30)
          ],
        );
}


  Widget loadSongs() {
  return FutureBuilder(
      future: getSongs(),
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
              return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                          height: 5,
                      );
                  },
                  itemBuilder: (BuildContext context, int index) {
                      return createSongEntry(
                          index + 1, snapshot.data![index]);
                  });
          } else {
              return const Center(child: CircularProgressIndicator());
          }
      }
  );
}



  Widget createSongList() {
    return Column(
      children: [
        createHeader(),
        if (isWeb())
          const Divider(
            color: Colors.grey,
            height: 0.1,
          ),
        loadSongs()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: isWeb()
          ? const EdgeInsets.all(40)
          : const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: createSongList(),
    );
  }
}
