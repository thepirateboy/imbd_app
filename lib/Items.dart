import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  String title;
  String year;
  String imdbID;
  String type;
  String cover;
  MovieCard(
      {required this.title,
      required this.year,
      required this.imdbID,
      required this.cover,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32))),
      child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     "$title",
          //     style: TextStyle(fontWeight: FontWeight.w700),
          //   ),
          // ),
          Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Image(
                image: NetworkImage(cover),
              ),
            ),
          ),
          // Text("$year"),
          // Text(imdbID),
          // Text(type),
          SizedBox(
            height: 20,
          ),
        ],
      ),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.all(Radius.circular(16)),
      //   // boxShadow: [
      //   //   BoxShadow(
      //   //     blurRadius: 50.0,
      //   //     // spreadRadius: 5,
      //   //   )
      //   // ],
      // ),
    );
  }
}
