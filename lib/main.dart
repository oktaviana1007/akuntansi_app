
import 'package:akuntansi_app/LoginRegisterPage.dart';
import 'package:akuntansi_app/MenuUsers.dart';
import 'package:akuntansi_app/profil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SplashScreen.dart';

void main(){
  runApp(MyApp(
    
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

enum LoginStatus{
  notSignIn,
  signIn,
}

class _MainState extends State<Main> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getBool("success");
      _loginStatus = value == true
          ? LoginStatus.signIn
          :  LoginStatus.notSignIn;
    });
  }

   signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setBool("success", false);
      // preferences.setString("level", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus){
      case LoginStatus.notSignIn:
        return LoginPage();
        break;
      case LoginStatus.signIn:
        return MenuUsers(signOut);
        break;
    }
  }
}


