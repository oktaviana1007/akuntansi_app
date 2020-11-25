import 'package:akuntansi_app/LoginRegisterPage.dart';
import 'package:akuntansi_app/mainDrawer.dart';
import 'package:akuntansi_app/perusahaan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Profil extends StatefulWidget {
  // Profil({Key key}) : super(key: key);
  // final VoidCallback signOut;
  // Profil(this.signOut);

  @override
  ProfilState createState() => ProfilState();
}

class ProfilState extends State<Profil> {
  String name;
  String perusahaan;
  String alamat;
  String telepon;
  String emailp;
  String token;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      print("data : $token");
    });
  }

  Future getData() async {
    String apiURL = "http://34.87.189.146:8000/api/me";
    var data = await http.get(apiURL, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    var jsonData = json.decode(data.body);
    return jsonData;
  }

  Future updateData(
      String id,
      String name,
      String nama_perusahaan,
      String alamat_perusahaan,
      String telepon_perusahaan,
      String email_perusahaan) async {
    String apiURL = "http://34.87.189.146:8000/api/updateinfo";
    var data = await http.post(apiURL, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      "id": "$id",
      "name": "$name",
      "nama_perusahaan": "$nama_perusahaan",
      "alamat_perusahaan": "$alamat_perusahaan",
      "telepon_perusahaan": "$telepon_perusahaan",
      "email_perusahaan": "$email_perusahaan"
    });
    // print(data.statusCode);
    var jsonData = json.decode(data.body);
    // print(jsonData);

    return jsonData;
  }

  TextEditingController _nameController,
      perusahaanctrl,
      alamatctrl,
      teleponctrl,
      emailpctrl;
  setup() async {
    _nameController = TextEditingController(text: name);
    perusahaanctrl = TextEditingController(text: perusahaan);
    alamatctrl = TextEditingController(text: alamat);
    teleponctrl = TextEditingController(text: telepon);
    emailpctrl = TextEditingController(text: emailp);
  }

  // signOut(){
  //   setState(() {
  //     widget.signOut();
  //   });
  // }
  // _confirmResult(bool isYes, BuildContext context){
  //   if(isYes){
  //     widget.signOut();
  //     Navigator.pop(context);
  //   }else{
  //     Navigator.pop(context);
  //   }
  // }

  // dialog() {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("KELUAR"),
  //           content: SingleChildScrollView(
  //             child: ListBody(
  //               children: <Widget>[
  //                 Text("Apakah anda yakin untuk keluar dari akun anda?")
  //               ],
  //             ),
  //           ),
  //           actions: <Widget>[
  //             FlatButton(
  //               onPressed: ()=> _confirmResult(true, context),
  //               child: Text("Ya"),
  //             ),
  //             FlatButton(
  //               onPressed: ()=> _confirmResult(false, context),
  //               child: Text("Tidak"),
  //             )
  //           ],
  //         );
  //       });
  // }

  @override
  void initState() {
    super.initState();
    getData();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'PROFILE',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: Icon(Icons.arrow_back),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  name = snapshot.data['data']['name'];
                  perusahaan = snapshot.data['data']['nama_perusahaan'];
                  alamat = snapshot.data['data']['alamat_perusahaan'];
                  telepon = snapshot.data['data']['telepon_perusahaan'];
                  emailp = snapshot.data['data']['email_perusahaan'];
                  setup();
                  return Container(
                      child: Card(
                          child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.all(20),
                        trailing: Icon(Icons.edit),
                        onTap: () {
                          showDialog(
                              child: new AlertDialog(
                                title: Text("Ubah Data"),
                                content: SingleChildScrollView(
                                    child: ListBody(
                                  children: <Widget>[
                                    new Padding(
                                      padding:
                                          EdgeInsets.only(left: 10.0, top: 0.0),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Nama",
                                      ),
                                      controller: _nameController,
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "Nama Perusahaan"),
                                      controller: perusahaanctrl,
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "Alamat Perusahaan"),
                                      controller: alamatctrl,
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "Telepon Perusahaan"),
                                      keyboardType: TextInputType.phone,
                                      controller: teleponctrl,
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "Email Perusahaan"),
                                      keyboardType: TextInputType.emailAddress,
                                      controller: emailpctrl,
                                    ),
                                    new Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0,
                                            left: 20.0,
                                            right: 20.0)),
                                    new RaisedButton(
                                      color: Colors.blue,
                                      child: new Text("Simpan",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Product-Bold",
                                              fontSize: 18,
                                              letterSpacing: 1.0)),
                                      onPressed: () {
                                        updateData(
                                            snapshot.data['data']['id']
                                                .toString(),
                                            _nameController.text,
                                            perusahaanctrl.text,
                                            alamatctrl.text,
                                            teleponctrl.text,
                                            emailpctrl.text);
                                        setState(() {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        });
                                      },
                                    )
                                  ],
                                )),
                              ),
                              context: context);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => Perusahaan()),
                          // );
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://png.pngtree.com/png-clipart/20190614/original/pngtree-vector-shop-icon-png-image_3788233.jpg"),
                        ),
                        title: Text(snapshot.data['data']['nama_perusahaan']),
                        subtitle: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(snapshot.data['data']['email']),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                    snapshot.data['data']['alamat_perusahaan']),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            Container(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Tentang"),
                )),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      title: Text("Banyaknya transaksi"),
                      subtitle: Text("3"),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      title: Text("Saldo awal"),
                      subtitle: Text("Rp. 0"),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      title: Text("Saldo saat ini"),
                      subtitle: Text("Rp. 0"),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      title: Text("Keluar"),
                      leading: Icon(Icons.logout),
                      onTap: () {
                        setState(() {
                          // dialog();
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
