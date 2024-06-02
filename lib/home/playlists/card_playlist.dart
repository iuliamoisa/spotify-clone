// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../playlist.dart';
import '../../platform.dart';
import '../../user.dart';
import '../../playlist_screen/playlist_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CardPlaylist extends StatelessWidget {
  Playlist playlist;
  User user;
  
  CardPlaylist({super.key, required this.playlist, required this.user});

  BorderRadius getRadius() {
    return isWeb()
        ? const BorderRadius.all(Radius.circular(10))
        : const BorderRadius.all(Radius.circular(2));
  }

  double getCardSize(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double size = width / 8.1;

    if (isWeb()) {
      if (width > 1384 && width < 1531) {
        size = width / 8.7;
      } else if (width > 1265 && width < 1384) {
        size = width / 7;
      } else if (width > 1165 && width < 1265) {
        size = width / 7.5;
      } else if (width > 1102 && width < 1165) {
        size = width / 7.9;
      } else if (width > 997 && width < 1102) {
        size = width / 6;
      } else if (width > 900 && width < 997) {
        size = width / 6.7;
      } else if (width > 813 && width < 900) {
        size = width / 4.5;
      } else if (width < 813) {
        size = width / 5.5;
      }
    } else {
      size = 100;
    }

    return size;
  }

  // Widget createPlaylistImage(double size) {
  //   return Container(
  //     decoration: BoxDecoration(color: Colors.blue, borderRadius: getRadius()),
  //     height: size,
  //     width: size,
  //   );
  // }

  Widget createPlaylistImage(double size) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.red, 
      borderRadius: getRadius()
    ),
    height: size,
    width: size,
    child: ClipRRect(
      borderRadius: getRadius(),
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
    return Container(
      padding: const EdgeInsets.all(5),
      child: Text(
        playlist.name,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
      ),
    );
  }

  Widget createPlaylistDescription() {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Text(
        playlist.description,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Color.fromRGBO(169, 169, 169, 1)),
      ),
    );
  }

  Widget createPlaylistContainer(double size) {
    var containerColor = isWeb()
        ? const Color.fromRGBO(40, 40, 40, 1)
        : const Color.fromRGBO(26, 26, 26, 1);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration:
          BoxDecoration(color: containerColor, borderRadius: getRadius()),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        createPlaylistImage(size),
        createPlaylistTitle(),
        createPlaylistDescription(),
      ]),
    );
  }

  double getConstraints(BuildContext context) {
    return isWeb() ? (getCardSize(context) + 20) : 125;
  }

  @override
  Widget build(BuildContext context) {
    double size = getCardSize(context);
    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (builder) {
            return PlaylistPage(
              user: user,
              playlist: playlist,
            );
          }));
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: getConstraints(context)),
          child: createPlaylistContainer(size),
        ));
  }
}
