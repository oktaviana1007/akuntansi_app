import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:akuntansi_app/LoginRegisterPage.dart';
import 'package:akuntansi_app/MenuUsers.dart';
import 'package:akuntansi_app/profil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
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

// class Main extends StatefulWidget {
//   @override
//   _MainState createState() => _MainState();
// }

// class _MainState extends State<Main> {
//   TextEditingController email = TextEditingController();
//   TextEditingController pass = TextEditingController();

//     Future login() async {
//     var url = "http://192.168.1.101/flutter-login-signup/login.php";
//     var response = await http.post(url, body: {
//       "username": email.text,
//       "password": pass.text,
//     });
//     var data = json.decode(response.body);
//     if (data == "Success") {
//       Fluttertoast(context).showToast(
//           child: Text(
//         'Login Successful',
//         style: TextStyle(fontSize: 25, color: Colors.green),
//       ));
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard(),),);
//     } else {
//       FlutterToast(context).showToast(
//           child: Text('Username and password invalid',
//               style: TextStyle(fontSize: 25, color: Colors.red)));
//     }
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }

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
         Profil(signOut);
        break;
    }
  }
}


