import 'dart:async';

import 'package:flutter/material.dart';
import 'package:manu/routes/routes.dart';
import 'package:manu/routes/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';



bool logged = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? name = preferences.getString("account__name");
  String? phone = preferences.getString("account__phone");
  String? message = preferences.getString("account__message");

  logged = name != null && phone != null && message != null;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        theme: ThemeData(
            fontFamily: 'Poppins'
        ),
        debugShowCheckedModeBanner: false,
        title: "Alert",
        initialRoute: logged ? RoutesName.welcome :RoutesName.setupView,
        onGenerateRoute: Routes.generateRoute,
        locale: const Locale('fr', 'FR'),
        home: const MyApp()
    );
  }
}