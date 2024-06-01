class Playlist {
  int playlistId = 0;
  String name = "Playlist Name";
  String description = 'description';
  String playlistType = "Public Playlist";
  String owner = "Username";
  int likes = 0;
  int songsCount = 0;
  String duration = "";
  List songs = [];

  Playlist(Map playlistData) {
    playlistId = playlistData['id'];
    name = playlistData['name'];
    description = playlistData['description'];
    playlistType = playlistData['type'];
    owner = playlistData['owner'];
    likes = playlistData['likes'];
    songs = playlistData['songs'];
    songsCount = songs.length;
  }
}


// class Playlist {
//   final int playlistId;
//   final String name;
//   final String description;
//   final String playlistType;
//   final String owner;
//   final int likes;
//   final int songsCount;
//   final String duration;
//   final List<String> songs;

//   Playlist({
//     required this.playlistId,
//     required this.name,
//     required this.description,
//     required this.playlistType,
//     required this.owner,
//     required this.likes,
//     required this.songs,
//   })  : songsCount = songs.length,
//         duration = _calculateDuration(songs);

//   factory Playlist.fromMap(Map<String, dynamic> playlistData) {
//     return Playlist(
//       playlistId: playlistData['id'],
//       name: playlistData['name'],
//       description: playlistData['description'],
//       playlistType: playlistData['type'],
//       owner: playlistData['owner'],
//       likes: playlistData['likes'],
//       songs: List<String>.from(playlistData['songs']),
//     );
//   }

//   // Function to calculate the total duration of the playlist
//   static String _calculateDuration(List<String> songs) {
//     // Placeholder implementation
//     // In a real scenario, you would parse song durations and sum them up
//     return "0:00"; // Placeholder for total duration
//   }
// }
