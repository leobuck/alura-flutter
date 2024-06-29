import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meetups/http/web.dart';
import 'package:meetups/models/device.dart';
import 'package:meetups/screens/events_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCQUdBe3OGQ5jjcKpIJ51BAP0OWu5U5sTQ",
      appId: "1:694386983691:web:139196b60165894331580e",
      messagingSenderId: "694386983691",
      projectId: "dev-meetups-47f24",
      authDomain: "dev-meetups-47f24.firebaseapp.com",
      storageBucket: "dev-meetups-47f24.appspot.com",
      measurementId: "G-426WWWEHH3",
    ),
  );
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
    print('Permissão concedida pelo usuário: ${settings.authorizationStatus}');
    _startPushNotificationsHandler(messaging);
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print(
        'Permissão concedida provisoriamente pelo usuário: ${settings.authorizationStatus}');
    _startPushNotificationsHandler(messaging);
  } else {
    print('Permissão negada pelo usuário');
  }

  runApp(App());
}

void _startPushNotificationsHandler(FirebaseMessaging messaging) async {
  String? token = await messaging.getToken(
    vapidKey:
        'BNhKEnoALuIpWPHHiBbjO8OPOW0rtBBOAsZZ13ubQ-Uw4_C2SkfnwyZqv-Qukk_Uufmp2W7wCIMem2vA6Qo6y-4',
  );
  print('TOKEN: $token');
  _setPushToken(token);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Recebi uma mensagem enquanto estava com o App aberto!');
    print('Dados da mensagem: ${message.data}');
    if (message.notification != null) {
      print(
          'A mensagem também continha uma notificação: ${message.notification?.title}, ${message.notification?.body}');
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  var notification = await FirebaseMessaging.instance.getInitialMessage();
  if (notification != null && notification.data['message'].length > 0) {
    showMyDialog(notification.data['message']);
  }
}

void showMyDialog(String message) {
  Widget okButton = OutlinedButton(
    onPressed: () => Navigator.pop(navigatorKey.currentContext!),
    child: Text('OK!'),
  );
  AlertDialog alerta = AlertDialog(
    title: Text('Promoção Imperdível'),
    content: Text(message),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(
      "Mensagem recebida em background: ${message.notification?.title}, ${message.notification?.body}");
}

void _setPushToken(String? token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? prefsToken = prefs.getString('pushToken');
  bool? prefSent = prefs.getBool('tokenSent');
  print('Prefs Token: ${prefsToken}');

  if (prefsToken != token || (prefsToken == token && prefSent == false)) {
    print('Enviando o token para o servidor...');

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? brand;
    String? model;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Rodando no ${androidInfo.model}');
      model = androidInfo.model;
      brand = androidInfo.brand;
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Rodando no ${iosInfo.utsname.machine}');
      model = iosInfo.utsname.machine;
      brand = 'Apple';
    }

    Device device = Device(
      brand: brand,
      model: model,
      token: token,
    );
    sendDevice(device);
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dev meetups',
      home: EventsScreen(),
      navigatorKey: navigatorKey,
    );
  }
}
