class Song {
  int songId = 0;
  String title = "Song Name";
  String artist = "Artist Name";
  String album = "Album Name";
  double length = 0;

  Song(Map songData) {
    songId = songData['songId'];
    title = songData['title'];
    artist = songData['artist'];
    album = songData['album'];
    length = songData['length'];
  }
}

