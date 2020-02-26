import 'package:demo_app/common/configure/getit_configuration.dart';
import 'package:demo_app/presentation/splash/page/splash_page.dart';
import 'package:flutter/material.dart';

import 'common/routes/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjections();
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      title: 'my app',
      home: SplashScreen(),
      routes: Router.routes,
      onGenerateRoute: Router.onGenerateRoute,
    );
  }
}
