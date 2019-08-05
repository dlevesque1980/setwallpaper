import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:setwallpaper/setwallpaper.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _message = 'Unknown';

  @override
  void initState() {
    super.initState();
    //initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setWallpapers() async {
    String message;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      message = await Setwallpaper.setSystemWallpaper('https://www.bing.com/sa/simg/hpb/LaDigue_EN-CA1115245085_1080x1920.jpg');
    } on PlatformException {
      message = 'Failed to get platform version.';
    }

    try {
      message = await Setwallpaper.setLockedWallpaper('https://www.bing.com/sa/simg/hpb/LaDigue_EN-CA1115245085_1080x1920.jpg');
    } on PlatformException {
      message = 'Failed to get platform version.';
    }

    try {
      message = await Setwallpaper.setBothWallpaper('https://www.bing.com/sa/simg/hpb/LaDigue_EN-CA1115245085_1080x1920.jpg');
      message = "both wallpaper set";
    } on PlatformException {
      message = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Center(child: RaisedButton(onPressed: () => setWallpapers(), child: Text("SetWallpaper"))),
            Center(
              child: new Text('$_message\n'),
            ),
          ],
        ),
      ),
    );
  }
}
