// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../playlist.dart';
import 'card_playlist.dart';
import '../../user.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../../platform.dart';

class PlaylistRow extends StatefulWidget {
  String rowName;
  User user;
  String rowType;
  
  PlaylistRow({
    super.key,
    required this.rowName,
    required this.user,
    required this.rowType
  });

  @override
  State<PlaylistRow> createState() => _PlaylistRowState();
}

class _PlaylistRowState extends State<PlaylistRow> {
  double getPadding() {
    return isWeb() ? 30 : 10;
  }

  List<Widget> createPlaylistCards(BuildContext context, List playlists, String rowType) {
    List<Widget> cards = [];
    int cardsPerRow = 5;
    double dividerSize = 10;

    if (isWeb()) {
      dividerSize = 20;
      if (MediaQuery.of(context).size.width > 1102 && MediaQuery.of(context).size.width <= 1384) {
        cardsPerRow = 4;
      } else if (MediaQuery.of(context).size.width > 900 && MediaQuery.of(context).size.width <= 1102) {
        cardsPerRow = 3;
      } else if (MediaQuery.of(context).size.width <= 900) {
        cardsPerRow = 2;
      }
    }

    if (playlists.length < cardsPerRow) {
      cardsPerRow = playlists.length;
    }

    for (int i = 0; i < cardsPerRow; i++) {
      cards.add(CardPlaylist(playlist: Playlist(playlists[i]), user: widget.user));
      cards.add(Container(width: dividerSize));
    }

    return cards;
  }

  Future<List> getRowPlaylists(String rowType) async {
    List userPlaylists = [];
    List rowPlaylists = [];
    final String response = await rootBundle.loadString('assets/playlists.json');
    final data = await json.decode(response);
    
    setState(() {
      List users = data['users'];
      for (var u in users) {
        if (u['userId'] == widget.user.id) {
          userPlaylists = u['playlists'];
        }
      }
    });

    for (var playlist in userPlaylists) {
      if (playlist['type'] == rowType) rowPlaylists.add(playlist);
    }

    if (rowType == "uniquely_yours") {
      rowPlaylists.add({
        "id": 0,
        "name": "Liked Songs",
        "description": "",
        "type": "uniquely_yours",
        "owner": "user",
        "likes": 1,
        "songs": widget.user.likedSongs,
        "imageUrl": "https://i.scdn.co/image/ab67706c0000da8470d229cb865e8d81cdce0889"
      });
    }

    return rowPlaylists;
  }

  Widget createRow(BuildContext context, List playlists, String rowType) {
    List<Widget> cardPlaylists = createPlaylistCards(context, playlists, rowType);
    
    return isWeb()
        ? Row(
            children: cardPlaylists,
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: cardPlaylists));
  }

  Widget createRowTitle() {
    return Text(
      widget.rowName,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
    );
  }

  Widget createPlaylistsRow() {
    return FutureBuilder(
      future: getRowPlaylists(widget.rowType),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return createRow(context, snapshot.data!, widget.rowType);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(188, 0, 0, 0),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(getPadding()),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [createRowTitle(), createPlaylistsRow()],
          ),
        ));
  }
}
