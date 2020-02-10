import 'dart:async';

import 'package:demo_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String _token ;
  bool _check = false;
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    checkToken();
    startTime();
  }

  Future<void> navigationPage() async {
    
    
    
    Navigator.of(context).pushReplacementNamed(_token == null ?Routes.login :Routes.home);
 
    
  }

  Future<void> checkToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _token = sharedPreferences.getString("token");
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Image.asset('assets/logo/splash.jpg'),
      ),
    );
  }
}