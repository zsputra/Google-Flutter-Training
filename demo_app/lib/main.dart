
import 'package:demo_app/pages/splash_page.dart';
import 'package:demo_app/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(HomePage());

}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      title: 'my app',
      home: SplashScreen(),
      routes: Router.routes,
    );
  }
}
