import 'package:flutter/material.dart';



void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 100, 10, 10),
                child: Text(
                  "Mech Store India",
                  style: TextStyle(fontSize: 28),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Image(
                    image: AssetImage("images/jamie-street-p2ifKHu3dXM-unsplash.jpg"),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}