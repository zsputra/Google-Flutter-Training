import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final inputToken = TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        labelText: 'Enter Token',
      ),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.pushNamed(context, '/HomeScreen');
        },
        child: Text("Login",
            textAlign: TextAlign.center,
//            style: style.copyWith(
//                color: Colors.white, fontWeight: FontWeight.bold)
        ),
      ),
    );
    return Scaffold(body: Center(
      child: Padding(
        padding: EdgeInsets.all(36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(alignment: Alignment.topLeft, child: Text('Token'),),
            SizedBox(
              height: 10,
            ),
            inputToken,
            SizedBox(
              height: 10,
            ),
            loginButon
          ],
        ),
      ),
    ));
  }
}
