import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultScreen extends StatefulWidget {
  static const id = "ResultScreen";
  late String title;

  ResultScreen({required this.title});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool error = false;
  Future<List<MovieCard>> _getCards() async {
    List<MovieCard> theCardList = [];
    var data = await http.get(Uri.parse(
        "http://www.omdbapi.com/?&apikey=349e0b0c&s=${widget.title}"));

    if (data.statusCode == 200) {
      var jsonData = json.decode(data.body);

      if (!jsonData.toString().contains("Response: False")) {
        setState(() {
          for (int i = 0; i < jsonData['Search'].length; i++) {
            theCardList.add(MovieCard(
              title: jsonData['Search'][i]['Title'],
              year: jsonData['Search'][i]['Year'],
              imdbID: jsonData['Search'][i]['imdbID'],
              type: jsonData['Search'][i]['Type'],
              cover: jsonData['Search'][i]['Poster'],
            ));
          }
        });
      } else {
        setState(() {
          error = true;
        });
      }
    } else {
      print("FAILED");
    }

    return theCardList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _getCards(),
          builder:
              (BuildContext context, AsyncSnapshot<List<MovieCard>> snapshot) {
            if (error == true) {
              return Text("ERROR");
            } else if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator.adaptive());
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: snapshot.data![index],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

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
    return Container(
      child: Column(
        children: [
          Text(
            "$title",
            style: TextStyle(color: Colors.red),
          ),
          Image(image: NetworkImage(cover)),
          Text("$year"),
          Text(imdbID),
          Text(type),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
