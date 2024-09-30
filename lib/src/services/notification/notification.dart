import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:loginkeycloakapp/main.dart';
import 'package:loginkeycloakapp/src/services/auth/tokenStorage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final TokenStorage tokenStorage = TokenStorage();

class Notification_Api {
  Future<void> sendTokenToNovu(String token) async {
    const novuApiUrl = "https://novu-api.aonetek.vn/v1/subscribers";
    const apikey = "39a047eab1b9bd2da4ef43491397b2ee";

    String? accessToken = await tokenStorage.getAccessToken();
    if (accessToken != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
      String? subscriberId = decodedToken['sub'];

      // Map<String, dynamic> decodedTokens = JwtDecoder.decode(accessToken);
      String? email = decodedToken['email'];

      if (subscriberId != null) {
        final response = await http.post(
          Uri.parse(novuApiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'ApiKey $apikey',
            'name': 'workflowedit',
            'deviceTokens': token,
          },
          body: jsonEncode(<String, dynamic>{
            'subscriberId': subscriberId,
            "email": email,
            "phone": "0352923442",
          }),
        );

        if (response.statusCode == 201) {
          print("Token successfully sent to Novu!, ${response.body}");
        } else {
          print(
              "Failed to send token to Novu: ${response.statusCode}, ${response.body}");
        }
      } else {
        print("Failed to extract subscriberId from token.");
      }
    } else {
      print("No access token available.");
    }
  }

  void sendPushNotification(String title, String body) async {
    const novuApiUrl = "https://novu-api.aonetek.vn/v1/events/trigger";
    const apiKey = '39a047eab1b9bd2da4ef43491397b2ee';

    String? accessToken = await tokenStorage.getAccessToken();
    if (accessToken != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
      String? subscriberId = decodedToken['sub'];
      // Map<String, dynamic> decodedTokens = JwtDecoder.decode(accessToken);
      String? email = decodedToken['email'];
      if (subscriberId != null) {
        final response = await http.post(
          Uri.parse(novuApiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'ApiKey $apiKey',
          },
          body: jsonEncode(<String, dynamic>{
            'name': 'workflowedit',
            'to': {
              'subscriberId': subscriberId,
              "email": email,
            },
            'payload': {'title': title, 'body': body},
          }),
        );

        if (response.statusCode == 201) {
          print("Push Notification sent successfully!");
        } else {
          print(
              "Failed to send Push Notification: ${response.statusCode}, ${response.body}");
        }
      } else {
        print("Failed to extract subscriberId from token.");
      }
    } else {
      print("No access token available.");
    }
  }

  Future<void> updateCredentials(String token) async {
    String? accessToken = await tokenStorage.getAccessToken();
    if (accessToken != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
      String? subscriberId = decodedToken['sub'];
      if (subscriberId != null) {
        final url = Uri.parse(
            'https://novu-api.aonetek.vn/v1/subscribers/$subscriberId/credentials');
        final headers = {
          'Content-Type': 'application/json',
          'Authorization': 'ApiKey 39a047eab1b9bd2da4ef43491397b2ee',
        };
        final body = json.encode({
          "credentials": {
            "deviceTokens": [token]
          },
          "providerId": "fcm",
        });

        final response = await http.put(url, headers: headers, body: body);
        if (response.statusCode == 200) {
          print('Credentials updated successfully');
        } else {
          print(
              'Failed to update credentials. Status code: ${response.statusCode}');
        }
      } else {
        print("subscriber ID không tồn tại");
      }
    }
  }

  void setupFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      // createNotificationChannel();
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'push Notifications',
              channelDescription:
                  'This channel is used for important notifications.',
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
    String? token = await messaging.getToken();
    print("FCM Token: $token");

    if (token != null) {
      // await _sendTokenToNovu(token);
      await sendTokenToNovu(token);
      await updateCredentials(token);
    }
  }
}
