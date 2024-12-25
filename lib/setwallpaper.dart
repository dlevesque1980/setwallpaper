
import 'dart:async';
import 'package:flutter/services.dart';

class Setwallpaper {


  Setwallpaper._privateConstructor();

  static final Setwallpaper _instance = Setwallpaper._privateConstructor();

  static Setwallpaper get instance => _instance;

  final methodChannel = const MethodChannel('didisoft.wallpaper');

  Future<String> setSystemWallpaper(String url) async {
    final String? message = await methodChannel.invokeMethod('setsystemwallpaper',{'url': url, 'system': true, 'locked': false});
    print('the value: $message');
    return message!;
  }

  Future<String> setLockedWallpaper(String url) async {
    final String? message = await methodChannel.invokeMethod('setlockedwallpaper',{'url': url, 'system': false, 'locked': true});
    return message!;
  }

  Future<String> setBothWallpaper(String url) async {
    final String? message = await methodChannel.invokeMethod('setbothwallpaper',{'url': url, 'system': true, 'locked': true});
    return message!;
  }
}
