import 'package:spotify/home/playlists/grid_playlists.dart';
import '../user.dart';
import '../platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class TopPlaylists extends StatefulWidget {
  final User user;
  const TopPlaylists({super.key, required this.user});

  @override
  State<TopPlaylists> createState() => _TopPlaylistsState();
}

class _TopPlaylistsState extends State<TopPlaylists> {
  String getMessage() {
    DateTime dateTime = DateTime.now();
    int currentHour = dateTime.hour;
    if (currentHour >= 6 && currentHour < 12) {
      return "Good morning";
    } else if (currentHour >= 12 && currentHour < 18) {
      return "Good afternoon";
    } else if (currentHour >= 18 && currentHour < 24) {
      return "Good evening";
    }
    return "Hello";
  }

  double setMessageSize() {
    return isWeb() ? 30 : 22;
  }

  double setPaddingSize() {
    return isWeb() ? 30 : 5;
  }

  int sortPlaylistsByNrOfClicks(dynamic first, dynamic second) {
    final nr1 = first['clicks'];
    final nr2 = second['clicks'];
    if (nr1 < nr2) {
      return 1;
    } else if (nr1 > nr2) {
      return -1;
    }
    return 0;
  }

  Future<List> getTopSixPlaylists() async {
    List userPlaylists = [];
    final String response =
        await rootBundle.loadString('assets/playlists.json');
    final data = await json.decode(response);
    setState(() {
      List users = data['users'];
      for (var user in users) {
        if (user['userId'] == widget.user.id) {
          userPlaylists = user['playlists'];
        }
      }
    });

    userPlaylists.sort(sortPlaylistsByNrOfClicks);
    return userPlaylists.take(6).toList();
  }

Widget createSectionTitle() {
  return Padding(
    padding: EdgeInsets.only(top: 20.0), 
    child: Text(
      getMessage(),
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: setMessageSize(),
          color: Colors.white),
    ),
  );
}


  Widget loadPlaylists() {
    return FutureBuilder(
      future: getTopSixPlaylists(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) =>
          snapshot.hasData
              ? GridPlaylists(
                  playlists: snapshot.data!,
                  user: widget.user,
                )
              : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget createTopPlaylistsBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [createSectionTitle(), loadPlaylists()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(168, 0, 0, 0),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.zero,
        child: createTopPlaylistsBody());
  }
}
