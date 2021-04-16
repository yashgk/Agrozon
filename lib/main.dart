import 'package:agrozon/Pages/LandingPage.dart';
import 'package:agrozon/Providers/UserProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>.value(value: UserProvider())
      ],
      child: MaterialApp(
        home: LandingPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
