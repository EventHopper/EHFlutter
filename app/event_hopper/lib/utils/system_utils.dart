import 'package:flutter/services.dart';

class SystemUtils {
  static Future<void> vibrate() async {
    await SystemChannels.platform.invokeMethod<void>('HapticFeedback.vibrate');
  }
}
