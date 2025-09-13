import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';

class DownloadService {
  static final Dio _dio = Dio();
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();

    const settings = InitializationSettings(android: android, iOS: ios);
    await _notificationsPlugin.initialize(
      settings,
    );
  }

  static Future<String> downloadFile({
    required String url,
    required String fileName,
    required Function(int received, int total) onProgress,
  }) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final safeFileName = fileName.replaceAll(RegExp(r'[^\w\s.-]'), '_');
      final filePath = "${dir.path}/$safeFileName";

      await _dio.download(
        url,
        filePath,
        onReceiveProgress: onProgress,
        options: Options(
          receiveTimeout: const Duration(minutes: 5),
          sendTimeout: const Duration(minutes: 5),
        ),
      );

      await _showNotification(safeFileName);
      _showSnackbar("Download complete", safeFileName);

      return filePath;
    } catch (e) {
      _showSnackbar("Download failed", e.toString());
      throw Exception("Download failed: $e");
    }
  }


  static Future<void> _showNotification(String fileName) async {
    const androidDetails = AndroidNotificationDetails(
      'download_channel',
      'Downloads',
      channelDescription: 'Notification channel for file downloads',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();
    const details = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notificationsPlugin.show(
      0,
      'Download Complete',
      fileName,
      details,
    );
  }


  static void _showSnackbar(String title, String message) {
    final screenWidth = Get.context?.width ?? 300.0;

    Get.snackbar(
      title,
      "",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xCC000000),
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      messageText: SizedBox(
        width: screenWidth * 0.8,
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
          maxLines: 5,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }
}
