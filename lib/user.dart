// class User {
//   int id;
//   String username;
//   List likedSongs;

//   User({required this.id, required this.username, required this.likedSongs});
// }

class User {
  int id;
  String username;
  List likedSongs;

  User({required this.id, required this.username, required this.likedSongs});

  // Method to add a song to the liked songs list
  void likeSong(String songId) {
    if (!likedSongs.contains(songId)) {
      likedSongs.add(songId);
    }
  }

  // Method to remove a song from the liked songs list
  void unlikeSong(String songId) {
    likedSongs.remove(songId);
  }

  // Method to check if a song is liked
  bool isLiked(String songId) {
    return likedSongs.contains(songId);
  }
}
