import 'package:akuntansi_app/API.dart';
import 'package:akuntansi_app/LoginRegisterPage.dart';
import 'package:akuntansi_app/Norek.dart';
import 'package:akuntansi_app/mainDrawer.dart';
import 'package:akuntansi_app/perusahaan.dart';
import 'package:akuntansi_app/profil.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Pengaturan extends StatefulWidget {
  Pengaturan({Key key}) : super(key: key);

  @override
  PengaturanState createState() => PengaturanState();
}

class PengaturanState extends State<Pengaturan> {
  String name;
  String perusahaan;
  String alamat;
  String telepon;
  String emailp;
  String token;
  int id;
  String email, password;

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      id = preferences.getInt("id");
      print("data : $id");
    });
  }

  void deleteData() async {
    String apiURL = "http://34.87.189.146:8000/api/closeaccount";
    var response = await http.post(apiURL, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      'id': id
    });
    var data = jsonDecode(response.body);
    return data;
    // bool value = data['success'];
    // String message = data['message'];
    // if (value == true ) {
    //   setState(() {
    //     print(data);
    //     // print(token);
    //     // Navigator.pop(context);
    //     // _lihatData();
    //     // tampilToast(message);
    //   });
    // } else {
    //     // print(token);
    //   print("Gagal dihapus");
    // }
  }

  void check() async {
    final response = await http
        .post(BaseUrl.login, body: {"email": email, "password": password});
    final data = jsonDecode(response.body);
    bool success = data['success'];
    if (success == true) {
      setState(() {
        deleteData();
        Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => LoginPage(),
        ));
      });
    } else
      () {
        Text("maaf inputan anda salah");
      };
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      title: Text("Input email dan password akun"),
      content: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            right: -40.0,
            top: -105.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                child: Icon(Icons.close),
                backgroundColor: Colors.red,
              ),
            ),
          ),
          Form(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  // keyboardType: TextInputType.emailAddress,
                  validator: (e) {},
                  onSaved: (e) => email = e,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(labelText: "Email"),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (e) {
                    if (e.isEmpty) {
                      return "Kata Sandi Tidak Dapat Kosong";
                    } else {
                      if (e.length < 8) {
                        return "Kata Sandi Minimun 8 Karakter";
                      } else {
                        return null;
                      }
                    }
                  },
                  obscureText: _secureText,
                  onSaved: (e) => password = e,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                  decoration: InputDecoration(
                    labelText: "Kata Sandi",
                    suffixIcon: IconButton(
                      onPressed: showHide,
                      icon: Icon(_secureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    //  contentPadding: EdgeInsets.all(18),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
      actions: <Widget>[
        Container(
          width: 150,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new RaisedButton(
                child: new Text(
                  "Submit",
                  style: new TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  check();
                }),
          ),
        ),
      ],
    );
    showDialog(context: context, child: alertDialog);
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengaturan',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: Container(
        //color:Colors.blue,
        child: ListView(
          children: <Widget>[
            CustomListTile('Perusahaan', 'Edit data perusahaan', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profil()),
              );
            }),
            CustomListTile("No Rekening", 'Edit data no rekening', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Norek()),
              );
            }),
            CustomListTile(
              "Hapus Akun",
              'Hapus akun disini',
              () => confirm(),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  String sub;
  String text;
  Function onTap;

  CustomListTile(this.sub, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 10.0, top: 10.0),
      child: Container(
        child: InkWell(
          splashColor: Colors.black,
          onTap: onTap,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1.0),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(13),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        sub,
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                      Text(
                        text,
                        style: TextStyle(fontSize: 12.0, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
