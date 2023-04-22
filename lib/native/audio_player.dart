import 'package:flutter/services.dart';

class AudioPlayer {
  static MethodChannel methodChannel =
      const MethodChannel('audioPlayerChannel');
  static final AudioPlayer instance = AudioPlayer._internal();

  AudioPlayer._internal();

  static Future<void> playErrorNote() async {
    final result = await methodChannel.invokeMethod("playError", {});
    return result;
  }

  static Future<void> playSuccessNote() async {
    final result = await methodChannel.invokeMethod("playSuccess", {});
    return result;
  }
}
