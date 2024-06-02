import 'package:flutter/material.dart';
import '../../playlist.dart';
import '../../platform.dart';
import '../../user.dart';
import '../../playlist_screen/playlist_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SmallPlaylist extends StatelessWidget {
  final Playlist playlist;
  final User user;
  const SmallPlaylist({super.key, required this.playlist, required this.user});

  double setWidth(BuildContext context) {
    if (isWeb()) {
      if (MediaQuery.of(context).size.width > 1100 &&
          MediaQuery.of(context).size.width < 1250) {
        return MediaQuery.of(context).size.width / 4;
      } else if (MediaQuery.of(context).size.width < 1100) {
        return MediaQuery.of(context).size.width / 6;
      } else {
        return MediaQuery.of(context).size.width / 6;
      }
    }
    return 112;
  }

  double setSize() {
    if (isWeb()) {
      return 70;
    }
    return 55;
  }

  double setFontSize() {
    return isWeb() ? 15 : 12;
  }

  double setPadding() {
    return isWeb() ? 25 : 20;
  }

  Widget createPlaylistImage(double size) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))),
      width: size,
    child: ClipRRect(
      borderRadius:  BorderRadius.only(
              topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
      child: CachedNetworkImage(
        imageUrl: playlist.imageUrl,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
      ),
    ),
  );
}

  Widget createPlaylistTitle() {
    return Text(
      playlist.name,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: setFontSize(),
          color: Colors.white),
    );
  }

  Widget createPlaylistBody(BuildContext context, double size) {
    var bodyColor = isWeb()
        ? const Color.fromRGBO(44, 44, 52, 1)
        : const Color.fromRGBO(40, 40, 40, 1);
    return Row(
      children: [
        createPlaylistImage(size),
        Container(
            height: size,
            width: setWidth(context),
            padding:
                EdgeInsets.symmetric(vertical: setPadding(), horizontal: 6),
            decoration: BoxDecoration(
                color: bodyColor,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5))),
            child: createPlaylistTitle())
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double size = setSize();
    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (builder) {
            return PlaylistPage(
              user: user,
              playlist: playlist,
            );
          }));
        },
        child:
            SizedBox(height: size, child: createPlaylistBody(context, size)));
  }
}
