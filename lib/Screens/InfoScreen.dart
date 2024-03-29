import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InfoScreen extends StatefulWidget {
  String imdbID;
  String cover;
  InfoScreen({required this.imdbID, required this.cover});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  bool loading = true;
  String title = "";
  String rating = "";

  Future<String> _getData(String whatData) async {
    var data = await http.get(Uri.parse(
        "http://www.omdbapi.com/?&apikey=349e0b0c&i=${widget.imdbID}"));

    if (data.statusCode == 200) {
      var jsonData = json.decode(data.body);
      return jsonData[whatData];
    } else {
      return "Noting";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // alignment: Alignment.center,
        children: [
          Container(
            color: Color(0xffFFFFF),
            // height: 200,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            top: 50,
            // left: 0,
            // right: 0,
            // left: MediaQuery.of(context).size.width / 5,
            child: Row(
              children: [
                Container(
                  // color: Colors.amberAccent,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: theFutureBuilder(
                      imdbID: widget.imdbID,
                      whatData: "Title",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 140,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3))
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Image(
                  width: 200,
                  image: NetworkImage(widget.cover),
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 50,
            child: Container(
              child: theFutureBuilder(
                imdbID: widget.imdbID,
                whatData: "Rated",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
          ),
          Positioned(
            top: 90,
            left: 20,
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: Colors.amberAccent,
                    size: 20,
                  ),
                  SizedBox(width: 3),
                  theFutureBuilder(
                    imdbID: widget.imdbID,
                    whatData: "Ratings",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.blueGrey[400],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          Positioned(
            right: 10,
            top: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined),
                    SizedBox(width: 10),
                    theFutureBuilder(
                      imdbID: widget.imdbID,
                      whatData: "Year",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.format_quote_rounded),
                    SizedBox(width: 10),
                    theFutureBuilder(
                      imdbID: widget.imdbID,
                      whatData: "Type",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class theFutureBuilder extends StatelessWidget {
  // const theFutureBuilder({ Key? key }) : super(key: key);
  String imdbID;
  String whatData;
  TextStyle style;

  theFutureBuilder(
      {required this.imdbID, required this.whatData, required this.style});
  Future<String> _getData(String whatData) async {
    var data = await http
        .get(Uri.parse("http://www.omdbapi.com/?&apikey=349e0b0c&i=${imdbID}"));

    if (data.statusCode == 200) {
      var jsonData = json.decode(data.body);
      if (whatData == "Ratings") {
        return jsonData['Ratings'][0]['Value'];
      } else if (whatData == "Cover") {
        return jsonData['Poster'];
      } else {
        return jsonData[whatData];
      }
    } else {
      return "Noting";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(whatData),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (whatData == "Title") {
          return Text(
            snapshot.data.toString(),
            style: style,
          );
        } else {
          return Text(
            snapshot.data.toString(),
            style: style,
          );
        }
      },
    );
  }
}
