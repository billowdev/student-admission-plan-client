import 'dart:io' as io;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageUtil {
  static Future<void> setItem(String key, String value) async {
    if (io.Platform.isAndroid) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
    } else if (io.Platform.isIOS) {
      // iOS implementation using Flutter Secure Storage or Keychain
      const storage = FlutterSecureStorage();
      await storage.write(key: key, value: value);
    } else {
      throw Exception("Platform not supported");
    }
  }

  static Future<String?> getItem(String key) async {
    if (io.Platform.isAndroid) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    } else if (io.Platform.isIOS) {
      // iOS implementation using Flutter Secure Storage or Keychain
      const platform = MethodChannel('com.example.keychain');
      return await platform.invokeMethod('getItem', {'key': key});
    } else {
      throw Exception("Platform not supported");
    }
  }

  static Future<void> removeItem(String key) async {
    if (io.Platform.isAndroid) {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(key);
    } else if (io.Platform.isIOS) {
      // iOS implementation using Flutter Secure Storage or Keychain
      const platform = MethodChannel('com.example.keychain');
      await platform.invokeMethod('removeItem', {'key': key});
    } else {
      throw Exception("Platform not supported");
    }
  }
}
