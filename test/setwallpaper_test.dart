import 'package:flutter_test/flutter_test.dart';
import 'package:setwallpaper/setwallpaper.dart';
import 'package:setwallpaper/setwallpaper_platform_interface.dart';
import 'package:setwallpaper/setwallpaper_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSetwallpaperPlatform
    with MockPlatformInterfaceMixin
    implements SetwallpaperPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SetwallpaperPlatform initialPlatform = SetwallpaperPlatform.instance;

  test('$MethodChannelSetwallpaper is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSetwallpaper>());
  });

  test('getPlatformVersion', () async {
    Setwallpaper setwallpaperPlugin = Setwallpaper();
    MockSetwallpaperPlatform fakePlatform = MockSetwallpaperPlatform();
    SetwallpaperPlatform.instance = fakePlatform;

    expect(await setwallpaperPlugin.getPlatformVersion(), '42');
  });
}
