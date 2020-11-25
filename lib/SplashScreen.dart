import 'package:akuntansi_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    starSplashScreen();
  }

  starSplashScreen()async{
    var duration = const Duration(seconds: 5);
    return Timer(duration, (){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_){
          return Main();
        })
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/logosaku.png',
              width: 300.0,
              height: 100.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text('Solusi Akuntansi UMKM', style: TextStyle(fontStyle: FontStyle.normal , color: Colors.black, fontSize: 25, ),),
            ),
          ],
        ),
        )
    );

  }
}
