
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'DashboardScreen.dart';
import 'ForgetScreen.dart';
import 'LoginScreen.dart';
import 'RegisterScreen.dart';

import 'addScreen.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        // ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/login",
        routes: {
          "/login": (context) => LoginScreen(),
          "/register": (context) => RegisterScreen(),
          "/forget-password": (context) => ForgetScreen(),
          "/dasboard": (context) => DashBoardScreen(),
          "/add-screen": (context) => AddScreen(),
        },
      ),
    );
  }
}
