import 'package:flutter/material.dart';
import 'package:imbd_app/Networking.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultScreen extends StatefulWidget {
  // const ResultScreen({ Key? key }) : super(key: key);
  static const id = "ResultScreen";
  late String title;

  ResultScreen({required this.title});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool error = false;
  Future<List<MovieCard>> _getCards() async {
    List<MovieCard> users = [];
    var data = await http.get(Uri.parse(
        "http://www.omdbapi.com/?&apikey=349e0b0c&s=${widget.title}"));

    if (data.statusCode == 200) {
      var jsonData = json.decode(data.body);

      // print("-------");
      // print("${jsonData['Search'][4]['Title']}");
      // print("The json length = ${jsonData['Search'].length}");

      // print("json data = $jsonData");

      if (!jsonData.toString().contains("Response: False")) {
        setState(() {
          for (int i = 0; i < jsonData['Search'].length; i++) {
            users.add(MovieCard(
              title: jsonData['Search'][i]['Title'],
              description: jsonData['Search'][i]['Year'],
            ));
          }
        });
      } else {
        // print("error ea");
        setState(() {
          error = true;
        });
      }
    } else {
      print("FAILED");
    }

    // print(
    //     "the movie title and year = ${users[0].title} && ${users[0].description} ");

    // print(users.length);

    return users;
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

class ListTitle extends StatefulWidget {
  // const ListTitle({ Key? key }) : super(key: key);

  @override
  _ListTitleState createState() => _ListTitleState();
}

class _ListTitleState extends State<ListTitle> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return CircularProgressIndicator.adaptive();
      }
      if (snapshot.hasError) {
        return Text("Error :(");
      }
      List<MovieCard> movieList = [];

      return ListView(
        children: movieList,
      );
    });
  }
}

class MovieCard extends StatelessWidget {
  // const MovieCard({ Key? key }) : super(key: key);
  String title;
  String description;
  MovieCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("$title"),
          Text("$description"),
        ],
      ),
    );
  }
}
