import 'package:flutter/material.dart';
import '../user.dart';
import '../left_side_pannel.dart';
import '../navbar/android_navbar.dart';
import '../platform.dart';

class SearchPage extends StatefulWidget {
  final User user;

  const SearchPage({super.key, required this.user});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isWeb()
          ? Row(
              children: [
                LeftSidePannel(user: widget.user), // Bara laterală pentru web
                Expanded(
                  child: buildSearchBody(isWeb: true),
                ),
              ],
            )
          : buildSearchBody(), // Pe dispozitive mobile, afișează direct corpul căutării
      bottomNavigationBar: isWeb()
          ? null // Pe web, nu afișa bara de navigare de jos
          : AndroidNavBar(user: widget.user), // Pe dispozitive mobile, folosește bara de navigare Android
    );
  }

  Widget buildSearchBody({bool isWeb = false}) {
    return Column(
      children: [
        Container(
          color: Color.fromRGBO(26, 26, 26, 1),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Artists, songs, or podcasts',
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Browse all',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Color.fromRGBO(26, 26, 26, 1),
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isWeb ? 4 : 2, // Pe web afișează 4 categorii pe linie, altfel 2
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: isWeb ? 1 : 2, // Ajustează aspectul în funcție de dispozitiv
              ),
              itemCount: 10, // Number of categories to display
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.primaries[index % Colors.primaries.length],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Category ${index + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
