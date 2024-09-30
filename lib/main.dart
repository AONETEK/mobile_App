import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
// import 'package:loginkeycloakapp/src/components/drop_down.dart';
import 'package:loginkeycloakapp/src/services/auth/tokenStorage.dart';
import 'package:loginkeycloakapp/src/services/notification/notification.dart';
import './src/Widget/financial_card.dart';
import './src/Widget/side_menu.dart';

final TokenStorage tokenStorage = TokenStorage();
final Notification_Api notification_api = Notification_Api();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isBusy = false;
  int _selectedIndex = 0;
  PageController _pageController = PageController();
  final FlutterAppAuth _appAuth = const FlutterAppAuth();
  Map<String, dynamic>? decodedToken;
  String? sub;
  String? _refreshToken;
  String? _accessToken;
  String? _idToken;
  String? uniqueUserId;

  // Keycloak configuration
  final String _clientId = 'mobile-app';
  final String _redirectUrl = 'com.example.loginkeycloakapp://login-callback';
  final String _issuer = 'https://login.aonetek.vn/auth/realms/aketoan-dev';
  final String _discoveryUrl =
      'https://login.aonetek.vn/auth/realms/aketoan-dev/.well-known/openid-configuration';
  final String _postLogoutRedirectUrl = 'com.example.loginkeycloakapp:/';
  final List<String> _scopes = <String>[
    'openid',
    'profile',
    'email',
  ];

  final AuthorizationServiceConfiguration _serviceConfiguration =
      const AuthorizationServiceConfiguration(
    authorizationEndpoint:
        'https://login.aonetek.vn/auth/realms/aketoan-dev/protocol/openid-connect/auth',
    tokenEndpoint:
        'https://login.aonetek.vn/auth/realms/aketoan-dev/protocol/openid-connect/token',
    endSessionEndpoint:
        'https://login.aonetek.vn/auth/realms/aketoan-dev/protocol/openid-connect/logout',
  );

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    // createNotificationChannel;
    print('_isBusy is now: $_isBusy');
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  void _setupFirebaseMessaging() async {
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
      await notification_api.sendTokenToNovu(token);
      await notification_api.updateCredentials(token);
    }
  }

  Future<void> _sendTokenToNovu(String token) async {
    const novuApiUrl = "https://novu-api.aonetek.vn/v1/subscribers";
    const apikey = "39a047eab1b9bd2da4ef43491397b2ee";

    String? accessToken = await tokenStorage.getAccessToken();
    if (accessToken != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
      String? subscriberId = decodedToken['sub'];

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
            "email": "hoduclam24082002hight@gmail.com",
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

  Future<void> _checkLoginStatus() async {
    setState(() {
      _isBusy = true;
    });

    _accessToken = await tokenStorage.getAccessToken();
    _refreshToken = await tokenStorage.getRefreshToken();

    if (_accessToken == null || _refreshToken == null) {
      await _signInWithAutoCodeExchange();
    } else if (_accessToken != null && !JwtDecoder.isExpired(_accessToken!)) {
      setState(() {
        _isBusy = false;
      });
    } else if (_refreshToken != null && !JwtDecoder.isExpired(_refreshToken!)) {
      await _refresh();
    } else {
      await _clearSessionInfo();
      await _signInWithAutoCodeExchange();
    }

    setState(() {
      _isBusy = false;
    });
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: _buildSelectedScreen(),
      bottomNavigationBar: GNav(
        backgroundColor: Colors.black,
        color: Colors.white,
        activeColor: Colors.white,
        tabBackgroundColor: Color.fromARGB(232, 70, 59, 59),
        padding: EdgeInsets.all(20),
        gap: 8,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        tabs: const [
          GButton(
            icon: Icons.home,
            text: "Home",
          ),
          GButton(
            icon: Icons.business,
            text: "Management",
          ),
          GButton(
            icon: Icons.chat,
            text: "Chat",
          ),
          GButton(
            icon: Icons.settings,
            text: "Setting",
          )
        ],
      ),
    );
  }

  Widget _buildSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboard();
      case 1:
        return _buildManagementScreen();
      case 2:
        return _buildChatScreen();
      case 3:
        return _buildSettingsScreen();
      default:
        return _buildDashboard();
    }
  }

  // Widget _buildHomeScreen() {
  //   // Replace with your Home screen content
  //   return Center(child: Text('Home screen'));
  // }
  Widget _buildDashboard() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Image.asset(
                'assets/logo_bot.png',
                height: 100,
                width: 100,
              ),
              Column(
                children: [
                  Text(
                    'Xin chào Lâm Code!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Chúc bạn một ngày tuyệt vời nhá!',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )
            ]),
            // Row(
            //   children: [PageDropDownComponent()],
            // ),
            // child: ElevatedButton(onPressed: onPressed, child: child),
            SizedBox(height: 16),
            Text(
              'Thuế',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FinancialCard(
                  title: 'Thuế \n GTGT',
                  icon: Icons.currency_exchange_rounded,
                  color: Color.fromARGB(255, 226, 105, 40),
                ),
                FinancialCard(
                  title: 'Thuế \n TNCN ',
                  icon: Icons.hourglass_empty,
                  color: Colors.blue,
                ),
                FinancialCard(
                  title: 'Bank Balance ',
                  icon: Icons.account_balance,
                  color: Colors.purple,
                ),
                FinancialCard(
                  title: 'Bank Balance',
                  icon: Icons.account_balance,
                  color: Colors.purple,
                ),
                FinancialCard(
                  title: 'Bank Balance',
                  icon: Icons.account_balance,
                  color: Colors.purple,
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Cài đặt nhanh',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FinancialCard(
                  title: 'Hóa đơn điện tử',
                  icon: Icons.receipt,
                  color: Colors.orange,
                ),
                FinancialCard(
                  title: 'Ngân hàng điện tử',
                  icon: Icons.account_balance,
                  color: Color.fromARGB(255, 67, 173, 212),
                ),
                FinancialCard(
                  title: 'Pending Payments',
                  icon: Icons.hourglass_empty,
                  color: Colors.blue,
                ),
                FinancialCard(
                  title: 'Bank Balance',
                  icon: Icons.account_balance,
                  color: Colors.purple,
                ),
                FinancialCard(
                  title: 'Bank Balance',
                  icon: Icons.account_balance,
                  color: Colors.purple,
                ),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(height: 16),
            // Container(
            //   height: 300,
            //   child: CashFlowChart(),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatScreen() {
    // Replace with your Chat screen content
    return Center(child: Text('Chat Screen'));
  }

  Widget _buildManagementScreen() {
    // Replace with your Management screen content
    return Center(child: Text('Management Screen'));
  }

  Widget _buildSettingsScreen() {
    // Replace with your Settings screen content
    return Center(child: Text('Settings Screen'));
  }

  Future<void> _refresh() async {
    try {
      _setBusyState();
      final TokenResponse? result = await _appAuth.token(TokenRequest(
        _clientId,
        _redirectUrl,
        refreshToken: _refreshToken,
        issuer: _issuer,
        scopes: _scopes,
        serviceConfiguration: _serviceConfiguration,
      ));

      if (result != null) {
        await tokenStorage.saveTokens(
            result.accessToken!, result.refreshToken!);
        _processTokenResponse(result);
      } else {
        await _signInWithAutoCodeExchange();
      }
    } catch (e) {
      print("Error refreshing token: $e");
      await _signInWithAutoCodeExchange();
    } finally {
      _clearBusyState();
    }
  }

  Future<void> _signInWithAutoCodeExchange(
      {bool preferEphemeralSession = false}) async {
    try {
      _setBusyState();

      final AuthorizationTokenResponse? result =
          await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          _clientId,
          _redirectUrl,
          issuer: _issuer,
          discoveryUrl: _discoveryUrl,
          serviceConfiguration: _serviceConfiguration,
          scopes: _scopes,
          preferEphemeralSession: preferEphemeralSession,
        ),
      );

      if (result != null) {
        await tokenStorage.saveTokens(
            result.accessToken!, result.refreshToken ?? '');
        decodedToken = JwtDecoder.decode(result.accessToken!);
        setState(() {
          _accessToken = result.accessToken!;
          _idToken = result.idToken!;
          _refreshToken = result.refreshToken!;
          sub = decodedToken?['sub'];
        });

        print("Sub:::: $decodedToken");
        print('Access Token: ${await tokenStorage.getAccessToken()}');
        print("Refresh Token: ${await tokenStorage.getRefreshToken()}");
        print("ID Token: ${result.idToken}");
      } else {
        print('Error: Null exchange code result.');
        await _signInWithAutoCodeExchange();
      }
    } catch (e) {
      print("Error during code exchange: $e");
      await _signInWithAutoCodeExchange();
    } finally {
      _clearBusyState();
    }
  }

  Future<void> _processAuthTokenResponse(
      AuthorizationTokenResponse response) async {
    try {
      if (response.refreshToken == null) {
        print('Error: refreshToken is null.');
        await _signInWithAutoCodeExchange();
        return;
      }

      final TokenResponse? result = await _appAuth.token(TokenRequest(
          _clientId, _redirectUrl,
          discoveryUrl: _discoveryUrl,
          refreshToken: response.refreshToken!,
          scopes: _scopes));

      if (result != null) {
        await tokenStorage.saveTokens(
            result.accessToken!, result.refreshToken!);
        _processTokenResponse(result);
      } else {
        print('Error: TokenResponse is null.');
        await _signInWithAutoCodeExchange();
      }
    } catch (e) {
      print("Error processing token: $e");
      await _signInWithAutoCodeExchange();
    }
  }

  void _processTokenResponse(TokenResponse response) {
    setState(() {
      _accessToken = response.accessToken!;
      _idToken = response.idToken!;
      _refreshToken = response.refreshToken!;
    });

    tokenStorage.saveTokens(response.accessToken!, response.refreshToken!);
  }

  Future<void> _endSession() async {
    try {
      _setBusyState();
      await _appAuth.endSession(EndSessionRequest(
          idTokenHint: _idToken,
          postLogoutRedirectUrl: _postLogoutRedirectUrl,
          serviceConfiguration: _serviceConfiguration));
      await _clearSessionInfo();
    } catch (_) {
      print("Error during session end.");
    } finally {
      _clearBusyState();
    }
  }

  Future<void> _clearSessionInfo() async {
    setState(() async {
      _accessToken = null;
      _idToken = null;
      _refreshToken = null;

      await tokenStorage.clearTokens();
    });
  }

  void _clearBusyState() {
    setState(() {
      _isBusy = false;
      print('_isBusy is now: $_isBusy');
    });
  }

  void _setBusyState() {
    setState(() {
      _isBusy = true;
      print('_isBusy is now: $_isBusy');
    });
  }
}
