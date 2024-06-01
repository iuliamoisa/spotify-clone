import 'package:flutter/material.dart';
import '../playlist_screen/playlist_page.dart';
import '../playlist.dart';
import '../user.dart';

class PlaylistButton extends StatelessWidget {
  final Playlist playlist;
  final User user;
  final bool isSelected;
  final Function(Playlist) onSelect;

  PlaylistButton({
    super.key,
    required this.playlist,
    required this.user,
    required this.isSelected,
    required this.onSelect,
  });

  Widget createNameText() {
    return Text(playlist.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: Colors.white,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      width: 250,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.grey : Colors.black,
          padding: EdgeInsets.all(0),
        ),
        onPressed: () {
          onSelect(playlist);
          Navigator.push(context, MaterialPageRoute(builder: (builder) {
            return PlaylistPage(
              playlist: playlist,
              user: user,
            );
          }));
        },
        child: SizedBox(
          width: double.infinity,
          child: Wrap(
            spacing: 10,
            children: [createNameText()],
          ),
        ),
      ),
    );
  }
}
