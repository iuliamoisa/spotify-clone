// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import '../../playlist.dart';
import '../../platform.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class PlaylistInfo extends StatefulWidget {
  Playlist playlist;
  PlaylistInfo({required this.playlist});

  @override
  State<PlaylistInfo> createState() => _PlaylistInfoState();
}

class _PlaylistInfoState extends State<PlaylistInfo> {
  Future<List> getSongs() async {
    List playlistSongs = [];
    final String response = await rootBundle.loadString('assets/songs.json');
    final data = await json.decode(response);
    setState(() {
      List songs = data['songs'];
      for (var song in songs) {
        if (widget.playlist.songs.contains(song['songId'])) {
          playlistSongs.add(song);
        }
      }
    });

    dynamic totalHours = 0.0;
    int totalMinutes = 0;
    int totalSeconds = 0;

    for (var song in playlistSongs) {
      var timeValue = song['length'];
      int minutes = timeValue.toInt();
      int seconds = ((timeValue - minutes) * 60).toInt();

      totalMinutes += minutes;
      totalSeconds += seconds;
    }

    totalMinutes += (totalSeconds ~/ 60);
    totalSeconds = totalSeconds % 60;

    totalHours = totalMinutes ~/ 60;
    totalMinutes = totalMinutes % 60;

    widget.playlist.duration = (totalHours != 0)
        ? '$totalHours hours $totalMinutes min $totalSeconds sec'
        : '$totalMinutes min $totalSeconds sec';

    return playlistSongs;
  }

  Widget loadDetails() {
    return FutureBuilder(
        future: getSongs(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) =>
            snapshot.hasData
                ? createDetails()
                : const Center(child: CircularProgressIndicator()));
  }

  TextStyle setStyle(double size) {
    return TextStyle(
        fontWeight: FontWeight.bold, fontSize: size, color: Colors.white);
  }

  Widget setPlaylistName() {
    double size = isWeb() ? 60 : 30;
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: Text(
        widget.playlist.name,
        style: setStyle(size),
      ),
    );
  }

  Widget createPlaylistImage() {
    return Container(
      height: isWeb() ? 225 : 200,
      width: isWeb() ? 225 : 200,
      color: Colors.black,
    );
  }

  Widget createDescription() {
    double size = isWeb() ? 15 : 12;
    return Text(
      widget.playlist.description,
      style: setStyle(size),
    );
  }

  Widget createDetails() {
    if (isWeb()) {
      String details = "${widget.playlist.owner} • "
          "${widget.playlist.likes} likes • "
          "${widget.playlist.songsCount} songs, "
          "${widget.playlist.duration}";
      return Text(
        details,
        style: setStyle(15),
      );
    }

    var userDetails = Row(
      children: [
        const Icon(Icons.account_circle, color: Colors.white, size: 23),
        Container(
          width: 5,
        ),
        Text(
          widget.playlist.owner,
          style: setStyle(15),
        )
      ],
    );

    String details =
        widget.playlist.likes != 0 ? "${widget.playlist.likes} likes • " : "";
    details += widget.playlist.duration;
    var playlistDetails = Row(
      children: [
        const Icon(Icons.language, color: Colors.white, size: 20),
        Container(
          width: 5,
        ),
        Text(
          details,
          style: setStyle(15),
        )
      ],
    );

    return Column(
      children: [
        userDetails,
        Container(
          height: 5,
        ),
        playlistDetails
      ],
    );
  }

  Widget createPlaylistInfo(BuildContext context) {
    return Container(
        height: isWeb() ? 250 : 200,
        width: isWeb() ? null : MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (isWeb()) Text('Playlist', style: setStyle(17)),
            setPlaylistName(),
            createDescription(),
            loadDetails()
          ],
        ));
  }

  List<Widget> createPlaylistInfoBody(BuildContext context) {
    return [createPlaylistImage(), createPlaylistInfo(context)];
  }

  @override
  Widget build(BuildContext context) {
    Widget componentType = isWeb()
        ? Row(children: createPlaylistInfoBody(context))
        : Column(children: createPlaylistInfoBody(context));

    var containerPadding = isWeb()
        ? const EdgeInsets.only(left: 25, right: 25, top: 60, bottom: 25)
        : const EdgeInsets.only(left: 5, right: 15, top: 100, bottom: 5);

    return Container(
      color: isWeb()
          ? const Color.fromRGBO(48, 48, 48, 1)
          : const Color.fromRGBO(26, 26, 26, 1),
      padding: containerPadding,
      child: componentType,
    );
  }
}
