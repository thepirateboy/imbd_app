import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imbd_app/Screens/InfoScreen.dart';

class MovieCard extends StatefulWidget {
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
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  Future<String> _getRating() async {
    var data = await http.get(Uri.parse(
        "http://www.omdbapi.com/?&apikey=349e0b0c&i=${widget.imdbID}"));

    if (data.statusCode == 200) {
      var jsonData = json.decode(data.body);
      return jsonData['Ratings'][0]['Value'];
    } else {
      return "Noting";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(widget.imdbID);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InfoScreen(
                      imdbID: widget.imdbID,
                      cover: widget.cover,
                    )));
      },
      child: Card(
        // color: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32))),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            // SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Image(
                image: NetworkImage(widget.cover),
                height: 350,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("${widget.year}"),
                  FutureBuilder(
                    future: _getRating(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.data == null) {
                        return CircularProgressIndicator.adaptive();
                      } else {
                        return Text(snapshot.data.toString());
                      }
                    },
                  ),
                ],
              ),
            ),

            // Text(imdbID),
            // Text(type),
            SizedBox(
              height: 10,
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
      ),
    );
  }
}
