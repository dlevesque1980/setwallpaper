import 'dart:async';

import 'package:flutter/services.dart';

class Setwallpaper {
  static const MethodChannel _channel =
  const MethodChannel('didisoft.wallpaper');

  static Future<String> setSystemWallpaper(String url) async {
    final String message = await _channel.invokeMethod('setsystemwallpaper',{'url': url});
    return message;
  }

  static Future<String> setLockedWallpaper(String url) async {
    final String message = await _channel.invokeMethod('setlockedwallpaper',{'url': url});
    return message;
  }

  static Future<String> setBothWallpaper(String url) async {
    final String message = await _channel.invokeMethod('setbothwallpaper',{'url': url});
    return message;
  }
}
