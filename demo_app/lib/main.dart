import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: Theme.of(context),
        title: 'my app',
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
      '/HomeScreen': (BuildContext context) => new MyHomePage()
    },
  );
  }
}

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          drawer: Drawer(
            child: Column(
              children: <Widget>[
                AppBar(
                  // leading: IconButton(icon: Icon(Icons.child_care), tooltip: 'Menu', onPressed: (){},),
                  automaticallyImplyLeading: false,
                  title: Text('Menu'),
                ),
                ListTile(
                  title: Text('Configure Movie'),
                  onTap: (){},
                )
              ],
            ),
          ),
          appBar: AppBar(
            title: Text("Movies Recomendation"),
          ),
        );
  }

}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  @override
void initState() {
  super.initState();
  startTime();
}

  void navigationPage() {
  Navigator.of(context).pushReplacementNamed('/HomeScreen');
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
