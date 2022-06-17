// ignore_for_file: prefer_const_constructors

import 'dart:html';

import 'package:arduino_blue_car/about.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // ignore: prefer_const_literals_to_create_immutables

          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'BLUETOOTH CAR CONTROLLER APP',
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            ListTile(
              leading: Icon(Icons.control_camera),
              title: Text('Controller'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.device_hub),
              title: Text('Connect Devices'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text('About'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => About()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: const <Widget>[Text("Hello")],
      ),
    );
  }
}
