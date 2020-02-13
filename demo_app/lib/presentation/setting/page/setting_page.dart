import 'package:demo_app/common/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // static SharedPreferences _sharedPreferences;
  bool _isChecked;
  //  = _sharedPreferences?.getBool("showRecomended") ?? true;

  _onChanged(bool value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _isChecked = value;
      _prefs.setBool("showRecomended", value);
    });
  }


  @override
  void initState() {
    _checkThe();
    super.initState();
  }

  Future<void> _checkThe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('showRecomended')){

      setState(() {
      bool check =  prefs.containsKey('showRecomended');
     if(check){
       _isChecked = prefs.getBool('showRecomended');
     } else{
       _isChecked = false;
     }
      });
    }
  }

  Widget _checkBox(bool checked){
    return CheckboxListTile(
            title: const Text('Show Recomended Movie'),
            value: checked,
            onChanged: _onChanged,
            secondary: const Icon(Icons.hourglass_empty),
          );
  }

  Widget _buildProgressBar() {
    return Center(child: CircularProgressIndicator());
  }

  Future<bool> getBoolSettingCheckbox() async {
    SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final bool = sharedPreferences.containsKey("showRecomended");
      if (bool) {
        return sharedPreferences.getBool("showRecomended");
      } else {
        return false;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        children: <Widget>[
          FutureBuilder(
                future: getBoolSettingCheckbox(),
                builder: (BuildContext context,
                    AsyncSnapshot<bool> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      !snapshot.hasError) {
                    _isChecked = snapshot.data;
                    return _checkBox(_isChecked);
                  } else {
                    return _buildProgressBar();
                  }
                },
              ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log Out'),
            onTap: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.remove("token");
              Navigator.pushReplacementNamed(context, Routes.login);
            },
          )
        ],
      ),
    ));
  }
}
