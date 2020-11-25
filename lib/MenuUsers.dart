import 'package:akuntansi_app/API.dart';
import 'package:akuntansi_app/DataTransaksi.dart';
import 'package:akuntansi_app/Pengaturan.dart';
import 'package:akuntansi_app/mainDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuUsers extends StatefulWidget {
  final VoidCallback signOut;
  MenuUsers(this.signOut);
  @override
  _MenuUsersState createState() => _MenuUsersState();
}

class _MenuUsersState extends State<MenuUsers> {

  signOut(){
    setState(() {
      widget.signOut();
    });
  }
  _confirmResult(bool isYes, BuildContext context){
    if(isYes){
      widget.signOut();
      Navigator.pop(context);
    }else{
      Navigator.pop(context);
    }
  }

  dialog() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("KELUAR"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Apakah anda yakin untuk keluar dari akun anda?")
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: ()=> _confirmResult(true, context),
                child: Text("Ya"),
              ),
              FlatButton(
                onPressed: ()=> _confirmResult(false, context),
                child: Text("Tidak"),
              )
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getPrefPraktikum();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      drawer: MainDrawer(),
        appBar: AppBar(
          title: Text("Jurnal"),
          actions: <Widget>[
            IconButton(
              onPressed: (){
                setState(() {
                  dialog();
                });
              },
              icon: Icon(Icons.power_settings_new),
            )
          ],
        ),

    body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Ringkasan Bisnis",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/filter.png')),
                      ),
                      child: FlatButton(
                        onPressed: (){
                        }, child: null),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
              child: Container(
                width: double.infinity,
                height: ScreenUtil.getInstance().setHeight(300),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 4.0),
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 4.0),
                    ]),
                child: Stack(fit: StackFit.expand, children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 20.0),
                    child: Text(
                      "PEMASUKAN",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0, bottom: 35.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[200],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 60.0, bottom: 35.0, right: 300.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0, left: 220.0),
                    child: Text("RP.   0,00",
                        style: TextStyle(color: Colors.white, fontSize: 22.0)),
                  )
                ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
              child: Container(
                width: double.infinity,
                height: ScreenUtil.getInstance().setHeight(300),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 4.0),
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 4.0),
                    ]),
                child: Stack(fit: StackFit.expand, children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 20.0),
                    child: Text(
                      "PENGELUARAN",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0, bottom: 35.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green[200],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 60.0, bottom: 35.0, right: 300.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0, left: 220.0),
                    child: Text("RP.   0,00",
                        style: TextStyle(color: Colors.white, fontSize: 22.0)),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
              child: Container(
                width: double.infinity,
                height: ScreenUtil.getInstance().setHeight(300),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 4.0),
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 4.0),
                    ]),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Stack(fit: StackFit.expand, children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        "LABA RUGI",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}