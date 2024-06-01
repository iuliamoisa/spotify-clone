// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:spotify/home/playlists/row_playlists.dart';
import 'package:spotify/home/top_playlists.dart';
import '../left_side_pannel.dart';
import '../user.dart';
import '../platform.dart';
import '../navbar/android_navbar.dart';

class Home extends StatelessWidget {
  final User user;
  const Home({super.key, required this.user});

  Widget createHomeBody(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    
    return Expanded(
      child: Container(
        color: Color.fromRGBO(26, 26, 26, 1),
        height: screenHeight,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopPlaylists(user: user),
              PlaylistRow(
                rowName: "Your top mixes",
                user: user,
                rowType: "spotify_mix",
              ),
              PlaylistRow(
                rowName: "Made for ${user.username}",
                user: user,
                rowType: "for_user",
              ),
              PlaylistRow(
                rowName: "Uniquely yours",
                user: user,
                rowType: "uniquely_yours",
              ),
              PlaylistRow(
                rowName: "Your playlists",
                user: user,
                rowType: "custom",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget createWebHome(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            LeftSidePannel(user: user),
            createHomeBody(context),
          ],
        ),
      ),
    );
  }

  Widget createAndroidHome(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [createHomeBody(context)],
      ),
      bottomNavigationBar: AndroidNavBar(user: user),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isWeb() ? createWebHome(context) : createAndroidHome(context);
  }
}
