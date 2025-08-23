# setwallpaper

A wallpaper plugin for Flutter that allows you to set wallpapers on Android devices.

## Getting Started

This plugin allows you to change the wallpaper and includes platform-specific implementation code for
Android only. (iOS does not support wallpaper change by external app.)

## Features

- Set system wallpaper from URL or bytes
- Set lock screen wallpaper from URL or bytes  
- Set both system and lock screen wallpapers from URL or bytes

## Usage

### Setting wallpaper from URL

```dart
import 'package:setwallpaper/setwallpaper.dart';

// Set system wallpaper
await Setwallpaper.instance.setSystemWallpaper('https://example.com/image.jpg');

// Set lock screen wallpaper
await Setwallpaper.instance.setLockedWallpaper('https://example.com/image.jpg');

// Set both system and lock screen wallpapers
await Setwallpaper.instance.setBothWallpaper('https://example.com/image.jpg');
```

### Setting wallpaper from bytes

```dart
import 'package:setwallpaper/setwallpaper.dart';
import 'dart:typed_data';

// Load image bytes (from assets, network, file, etc.)
Uint8List imageBytes = ...; // Your image bytes here

// Set system wallpaper from bytes
await Setwallpaper.instance.setSystemWallpaperFromBytes(imageBytes);

// Set lock screen wallpaper from bytes
await Setwallpaper.instance.setLockedWallpaperFromBytes(imageBytes);

// Set both system and lock screen wallpapers from bytes
await Setwallpaper.instance.setBothWallpaperFromBytes(imageBytes);
```

### Example: Loading image from assets

```dart
import 'package:flutter/services.dart';

// Load image from assets
final ByteData data = await rootBundle.load('assets/wallpaper.jpg');
final Uint8List bytes = data.buffer.asUint8List();

// Set as wallpaper
await Setwallpaper.instance.setSystemWallpaperFromBytes(bytes);
```

## Permissions

Add the following permission to your `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.SET_WALLPAPER" />
```

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
