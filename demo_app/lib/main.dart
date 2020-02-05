
import 'package:demo_app/pages/home_page.dart';
import 'package:demo_app/pages/login_page.dart';
import 'package:demo_app/pages/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      routes: <String, WidgetBuilder>{
        '/HomeScreen': (BuildContext context) =>  MyHomePage(),
        '/LoginPage' : (BuildContext context) => LoginPage(),
      },
    );
  }
}



