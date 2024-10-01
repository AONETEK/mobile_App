import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:loginkeycloakapp/src/services/auth/tokenStorage.dart';
import 'package:loginkeycloakapp/src/services/notification/notification.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './src/Widget/side_menu.dart';
import './src/screen/dashBoardScreen/dashBoardScreen.dart';
import './src/screen/chatScreen/chatScreen.dart';
import './src/screen/managementScreen/managementScreen.dart';
import './src/screen/settingScreen/settingScreen.dart';
import './src/utils/gnavWidget.dart';
import './src/utils/icon_title.dart';

final TokenStorage tokenStorage = TokenStorage();
final Notification_Api notification_api = Notification_Api();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");

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
  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final iconList = [
    IconTitle(icon: Icon(Icons.home, size: 24), title: 'Home'),
    IconTitle(icon: Icon(Icons.business, size: 24), title: 'Management'),
    IconTitle(icon: Icon(Icons.chat, size: 24), title: 'Chat'),
    IconTitle(icon: Icon(Icons.settings, size: 24), title: 'Setting'),
  ];
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
    print('_isBusy is now: $_isBusy');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideMenu(),
        appBar: AppBar(
          title: const Text('Menu'),
        ),
        body: _buildSelectedScreen(),
        bottomNavigationBar: GnavWidget(
          iconTitleList: iconList,
          onTabChange: _onTabChange,
          initialIndex: _selectedIndex,
        ));
  }

  Widget _buildSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return DashboardScreen();
      case 1:
        return ManagementScreen();
      case 2:
        return Chatscreen();
      case 3:
        return SettingScreen();
      default:
        return DashboardScreen();
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

  void _processTokenResponse(TokenResponse response) {
    setState(() {
      _accessToken = response.accessToken!;
      _idToken = response.idToken!;
      _refreshToken = response.refreshToken!;
    });

    tokenStorage.saveTokens(response.accessToken!, response.refreshToken!);
  }

  // Future<void> _endSession() async {
  //   try {
  //     _setBusyState();
  //     await _appAuth.endSession(EndSessionRequest(
  //         idTokenHint: _idToken,
  //         postLogoutRedirectUrl: _postLogoutRedirectUrl,
  //         serviceConfiguration: _serviceConfiguration));
  //     await _clearSessionInfo();
  //   } catch (_) {
  //     print("Error during session end.");
  //   } finally {
  //     _clearBusyState();
  //   }
  // }

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
