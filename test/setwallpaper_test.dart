import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:setwallpaper/setwallpaper.dart';
import 'dart:typed_data';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('didisoft.wallpaper');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return 'Wallpaper set successfully!';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  group('Setwallpaper URL methods', () {
    test('setSystemWallpaper', () async {
      final result = await Setwallpaper.instance.setSystemWallpaper('https://example.com/image.jpg');
      expect(result, 'Wallpaper set successfully!');
    });

    test('setLockedWallpaper', () async {
      final result = await Setwallpaper.instance.setLockedWallpaper('https://example.com/image.jpg');
      expect(result, 'Wallpaper set successfully!');
    });

    test('setBothWallpaper', () async {
      final result = await Setwallpaper.instance.setBothWallpaper('https://example.com/image.jpg');
      expect(result, 'Wallpaper set successfully!');
    });
  });

  group('Setwallpaper Bytes methods', () {
    test('setSystemWallpaperFromBytes', () async {
      final bytes = Uint8List.fromList([1, 2, 3, 4, 5]);
      final result = await Setwallpaper.instance.setSystemWallpaperFromBytes(bytes);
      expect(result, 'Wallpaper set successfully!');
    });

    test('setLockedWallpaperFromBytes', () async {
      final bytes = Uint8List.fromList([1, 2, 3, 4, 5]);
      final result = await Setwallpaper.instance.setLockedWallpaperFromBytes(bytes);
      expect(result, 'Wallpaper set successfully!');
    });

    test('setBothWallpaperFromBytes', () async {
      final bytes = Uint8List.fromList([1, 2, 3, 4, 5]);
      final result = await Setwallpaper.instance.setBothWallpaperFromBytes(bytes);
      expect(result, 'Wallpaper set successfully!');
    });
  });
}
