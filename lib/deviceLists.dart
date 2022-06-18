// ignore_for_file: deprecated_member_use, prefer_collection_literals, unnecessary_new, unused_element, unrelated_type_equality_checks, non_constant_identifier_names, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceLists extends StatefulWidget {
  DeviceLists({Key? key}) : super(key: key);

  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> deviceList = <BluetoothDevice>[];
  @override
  State<DeviceLists> createState() => _DeviceListsState();
}

class _DeviceListsState extends State<DeviceLists> {
  final _writeController = TextEditingController();
  late BluetoothDevice _connectedDevice;
  late List<BluetoothService> _services;

  _addDeviceToList(final BluetoothDevice device) {
    if (!widget.deviceList.contains(device)) {
      setState(() {
        widget.deviceList.add(device);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceToList(device);
      }
    });
    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceToList(result.device);
      }
    });
    widget.flutterBlue.startScan();
  }

  ListView _buildListViewOfDevices() {
    List<Container> containers = <Container>[];

    for (BluetoothDevice device in widget.deviceList) {
      containers.add(
        Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(device.name == '' ? 'Unknown Device' : device.name),
                    Text(device.id.toString()),
                  ],
                ),
              ),
              FlatButton(
                color: Colors.blue,
                child: const Text(
                  'Connect',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  widget.flutterBlue.stopScan();
                  try {
                    await device.connect();
                  } catch (e) {
                    if (e.hashCode != 'alrady_connected') {
                      throw e;
                    }
                  } finally {
                    _services = await device.discoverServices();
                  }
                  setState(() {
                    _connectedDevice = device;
                  });
                },
              ),
            ],
          ),
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  List<ButtonTheme> _buildWriteButton(BluetoothCharacteristic characteristic) {
    List<ButtonTheme> buttons = <ButtonTheme>[];
    if (characteristic.properties.write) {
      buttons.add(
        ButtonTheme(
          minWidth: 10,
          height: 20,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: RaisedButton(
              child: Text(
                'Write',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Write'),
                      content: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: _writeController,
                            ),
                          )
                        ],
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Send"),
                          onPressed: () {
                            characteristic.write(
                                utf8.encode(_writeController.value.text));
                            // Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      );
    }
    return buttons;
  }

  ListView _buildConnectedDeviceView() {
    List<Container> containers = <Container>[];

    for (BluetoothService service in _services) {
      List<Widget> CharacteristicsWidget = <Widget>[];
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        CharacteristicsWidget.add(
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      characteristic.uuid.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    ..._buildWriteButton(characteristic),
                  ],
                ),
                Row(
                  children: const <Widget>[
                    Text("Values: "),
                  ],
                ),
                Divider(),
              ],
            ),
          ),
        );
      }
      containers.add(
        Container(
          child: ExpansionTile(
            title: Text(
              service.uuid.toString(),
            ),
            children: CharacteristicsWidget,
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  ListView _buildView() {
    if (_connectedDevice != null) {
      return _buildConnectedDeviceView();
    }
    return _buildListViewOfDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BlueTooth Connection"),
      ),
      body: _buildView(),
    );
  }
}
