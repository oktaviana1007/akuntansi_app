import 'package:akuntansi_app/API.dart';
import 'package:akuntansi_app/DataTransaksi.dart';
import 'package:akuntansi_app/Pengaturan.dart';
import 'package:akuntansi_app/mainDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            // child: ListView(
            //   padding: EdgeInsets.all(16.0),
            //   shrinkWrap: true,
            //   children: <Widget>[
            //     Text(
            //       "Apakah Anda yakin untuk keluar dari Akun?",
            //       style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            //     ),
            //     SizedBox(
            //       height: 10.0,
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: <Widget>[
            //         InkWell(
            //             onTap: () {
            //               Navigator.pop(context);
            //             },
            //             child: Text("Tidak")),
            //         SizedBox(
            //           width: 16.0,
            //         ),
            //         InkWell(
            //             onTap: () {
            //               widget.signOut();
            //               Navigator.pop(context);
            //             },
            //             child: Text("Ya")),
            //       ],
            //     )
            //   ],
            // ),
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

      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=>DataTransaksi(),
                              ));
                            },
                            child: Container(
                              color: Colors.black26,
                              height: 100,
                              width: 100,
                              child: Center(child: Text('Jurnal')),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=>Pengaturan(),
                              ));
                            },
                            child: Container(
                              color: Colors.black26,
                              height: 100,
                              width: 100,
                              child: Center(child: Text('Pengaturan')),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(

                            child: Container(
                              color: Colors.black26,
                              height: 100,
                              width: 100,
                              child: Center(child: Text('menu 3')),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Container(
                              color: Colors.black26,
                              height: 100,
                              width: 100,
                              child: Center(child: Text('menu 4')),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],

            )

          ],
        ),
      )

    );
  }
}