import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Column(
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("ABOUT US"),
          ),
        ],
      ),
    );
  }
}
