import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InputScreen extends StatefulWidget {
  // const InputScreen({ Key? key }) : super(key: key);
  static const id = "InputSCreen";

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final searchController = TextEditingController();
  late String searchText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        // alignment: Alignment.center,
        children: [
          // todo: APP BAR
          Positioned(
            top: 50,
            // left: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Icon(FontAwesomeIcons.stream),
                    decoration: BoxDecoration(
                      color: Color(0xffD8D9DB),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                  Image.asset(
                    "lib/img/icons8-imdb-480.png",
                    width: 70,
                  ),
                  Icon(
                    FontAwesomeIcons.solidUserCircle,
                    size: 40,
                    color: Colors.grey[800],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 170,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                "Find Movies, TV shows, \nand more...",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Positioned(
            top: 290,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Color(0xffD8D9DB),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        icon: Icon(
                          FontAwesomeIcons.search,
                          size: 17,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        hintText: "Search Movies ...",
                      ),
                      onChanged: (value) {
                        searchText = value;
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 500,
            child: TextButton(
              child: Text("SEND"),
              onPressed: () {
                print(searchText);
              },
            ),
          )
        ],
      ),
    );
  }
}
