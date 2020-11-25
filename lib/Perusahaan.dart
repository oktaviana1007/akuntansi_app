import 'package:akuntansi_app/LoginRegisterPage.dart';
import 'package:akuntansi_app/mainDrawer.dart';
import 'package:akuntansi_app/model/dataperusahaan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Perusahaan extends StatefulWidget {
  Perusahaan({Key key}) : super(key: key);

  @override
  PerusahaanState createState() => PerusahaanState();
}

class PerusahaanState extends State<Perusahaan> {
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
    });
  }

  Future getData() async {
    String apiURL = "http://34.87.189.146:8000/api/me";
    var data = await http.get(apiURL, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    var jsonData = json.decode(data.body);
    // print("lala:" + jsonData);
    return jsonData;
  }

   Future<List<Dataperusahaan>> getData2() async {
    List<Dataperusahaan> list;
    String link = "http://34.87.189.146:8000/api/me";
    var res = await http.get(Uri.encodeFull(link), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    print("lala : "+res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["data"] as List;
      print(rest);
      list = rest.map<Dataperusahaan>((json) => Dataperusahaan.fromJson(json)).toList();
    }
    // var jsonData = json.decode(res.body);
    // print(jsonData);
    // print(res.statusCode);
    // return jsonData;
    // print("List Size: ${list.length}");
    // print(list);
    return list;
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

  @override
  void initState() {
    super.initState();
    setup();
    getPref();
    getData2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Pengaturan',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: FutureBuilder(
                  future: getData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      name = snapshot.data['data']['name'];
                      perusahaan = snapshot.data['data']['nama_perusahaan'];
                      alamat = snapshot.data['data']['alamat_perusahaan'];
                      telepon = snapshot.data['data']['telepon_perusahaan'];
                      emailp = snapshot.data['data']['email_perusahaan'];
                      return Container(
                          child: Card(
                              child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            contentPadding: EdgeInsets.all(20),
                            title:
                                Text(snapshot.data['data']['nama_perusahaan']),
                            subtitle: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(snapshot.data['data']['email']),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(snapshot.data['data']
                                        ['alamat_perusahaan']),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(snapshot.data['data']
                                        ['telepon_perusahaan']),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ButtonBar(
                            children: <Widget>[
                              FlatButton(
                                child: const Text('UBAH'),
                                onPressed: () {
                                  showDialog(
                                      child: new AlertDialog(
                                        title: Text("Ubah Data"),
                                        content: SingleChildScrollView(
                                            child: ListBody(
                                          children: <Widget>[
                                            new Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.0, top: 0.0),
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
                                                  labelText:
                                                      "Alamat Perusahaan"),
                                              controller: alamatctrl,
                                            ),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                  labelText:
                                                      "Telepon Perusahaan"),
                                              keyboardType: TextInputType.phone,
                                              controller: teleponctrl,
                                            ),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                  labelText:
                                                      "Email Perusahaan"),
                                              keyboardType:
                                                  TextInputType.emailAddress,
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
                                                      fontFamily:
                                                          "Product-Bold",
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
                                },
                              ),
                            ],
                          ),
                        ],
                      )));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
