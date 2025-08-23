import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:setwallpaper/setwallpaper.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _message = 'Unknown';

  @override
  void initState() {
    super.initState();
    //initPlatformState();
  }


  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setSystemWallpaper() async {
    String message;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      message = (await Setwallpaper.instance.setSystemWallpaper('https://www.bing.com/sa/simg/hpb/LaDigue_EN-CA1115245085_1080x1920.jpg'));
      message = "System wallpaper set";
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
  Future<void> setLockedWallpaper() async {
    String message;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      message = await Setwallpaper.instance.setLockedWallpaper('https://www.bing.com/sa/simg/hpb/LaDigue_EN-CA1115245085_1080x1920.jpg');
      message = "System wallpaper set";
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
  
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setWallpapers() async {
    String message;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      message = await Setwallpaper.instance.setBothWallpaper('https://www.bing.com/sa/simg/hpb/LaDigue_EN-CA1115245085_1080x1920.jpg');
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

  // Nouvelles méthodes pour les bytes
  Future<void> setSystemWallpaperFromBytes() async {
    String message;
    try {
      // Exemple : charger une image depuis les assets
      final ByteData data = await rootBundle.load('assets/sample_wallpaper.jpg');
      final Uint8List bytes = data.buffer.asUint8List();
      
      message = await Setwallpaper.instance.setSystemWallpaperFromBytes(bytes);
      message = "System wallpaper set from bytes";
    } on PlatformException {
      message = 'Failed to set wallpaper from bytes.';
    }

    if (!mounted) return;

    setState(() {
      _message = message;
    });
  }

  Future<void> setLockedWallpaperFromBytes() async {
    String message;
    try {
      // Exemple : charger une image depuis les assets
      final ByteData data = await rootBundle.load('assets/sample_wallpaper.jpg');
      final Uint8List bytes = data.buffer.asUint8List();
      
      message = await Setwallpaper.instance.setLockedWallpaperFromBytes(bytes);
      message = "Locked wallpaper set from bytes";
    } on PlatformException {
      message = 'Failed to set locked wallpaper from bytes.';
    }

    if (!mounted) return;

    setState(() {
      _message = message;
    });
  }

  Future<void> setBothWallpapersFromBytes() async {
    String message;
    try {
      // Exemple : charger une image depuis les assets
      final ByteData data = await rootBundle.load('assets/sample_wallpaper.jpg');
      final Uint8List bytes = data.buffer.asUint8List();
      
      message = await Setwallpaper.instance.setBothWallpaperFromBytes(bytes);
      message = "Both wallpapers set from bytes";
    } on PlatformException {
      message = 'Failed to set both wallpapers from bytes.';
    }

    if (!mounted) return;

    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              const Text('Méthodes avec URL:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Center(child: ElevatedButton(onPressed: () => setSystemWallpaper(), child: Text("SetSystemWallpaper"))),
              Center(child: ElevatedButton(onPressed: () => setLockedWallpaper(), child: Text("SetLockedWallpaper"))),
              Center(child: ElevatedButton(onPressed: () => setWallpapers(), child: Text("SetBothWallpapers"))),
              
              const SizedBox(height: 30),
              const Text('Méthodes avec Bytes:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Center(child: ElevatedButton(onPressed: () => setSystemWallpaperFromBytes(), child: Text("SetSystemWallpaper (Bytes)"))),
              Center(child: ElevatedButton(onPressed: () => setLockedWallpaperFromBytes(), child: Text("SetLockedWallpaper (Bytes)"))),
              Center(child: ElevatedButton(onPressed: () => setBothWallpapersFromBytes(), child: Text("SetBothWallpapers (Bytes)"))),
              
              const SizedBox(height: 20),
              Center(
                child: Text('$_message\n'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
