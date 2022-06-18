// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:arduino_blue_car/about.dart';
import 'package:arduino_blue_car/deviceLists.dart';
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
              leading: Icon(Icons.device_hub),
              title: Text('Connect Device'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeviceLists()),
                );
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(15),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Car Controls",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Note: First connect car using bluetooth ",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  height: 350,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Card(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () => {},
                            child: Icon(
                              Icons.arrow_upward,
                              size: 50,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () => {},
                                child: Icon(
                                  Icons.arrow_back_sharp,
                                  size: 50,
                                ),
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              ElevatedButton(
                                onPressed: () => {},
                                child: Icon(
                                  Icons.arrow_forward_sharp,
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () => {},
                            child: Icon(
                              Icons.arrow_downward,
                              size: 50,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
