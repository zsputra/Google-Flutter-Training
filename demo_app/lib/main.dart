
import 'package:demo_app/pages/splash/page/splash_page.dart';
import 'package:flutter/material.dart';

import 'common/routes/router.dart';


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
