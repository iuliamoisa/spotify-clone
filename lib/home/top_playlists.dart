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
    if (currentHour >= 5 && currentHour < 12) {
      return "Good morning";
    } else if (currentHour >= 12 && currentHour < 17) {
      return "Good afternoon";
    } else if (currentHour >= 17 && currentHour < 24) {
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

  int sortByClicks(dynamic a, dynamic b) {
    final propA = a['clicks'];
    final propB = b['clicks'];
    if (propA < propB) {
      return 1;
    } else if (propA > propB) {
      return -1;
    }
    return 0;
  }

  Future<List> getUserTopSixPlaylists() async {
    List userPlaylists = [];
    final String response =
        await rootBundle.loadString('assets/playlists.json');
    final data = await json.decode(response);
    setState(() {
      List users = data['users'];
      for (var u in users) {
        if (u['userId'] == widget.user.id) {
          userPlaylists = u['playlists'];
        }
      }
    });

    userPlaylists.sort(sortByClicks);
    // Using print is discouraged in production code, consider using a logging framework if needed
    // print(userPlaylists.take(6).toList());

    return userPlaylists.take(6).toList();
  }

  Widget createSectionTitle() {
    return Text(
      getMessage(),
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: setMessageSize(),
          color: Colors.white),
    );
  }

  Widget loadPlaylists() {
    return FutureBuilder(
      future: getUserTopSixPlaylists(),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [createSectionTitle(), loadPlaylists()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(168, 0, 0, 0),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(setPaddingSize()),
        child: createTopPlaylistsBody());
  }
}
