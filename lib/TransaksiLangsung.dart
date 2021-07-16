import 'dart:convert';
import 'package:akuntansi_app/API.dart';
import 'package:akuntansi_app/DataTransaksi.dart';
import 'package:akuntansi_app/datatransaksi2.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TambahDataTransaksiw extends StatefulWidget {
  // final VoidCallback reload;
  // TambahDataTransaksi(this.reload);
  @override
  _TambahDataTransaksiwState createState() => _TambahDataTransaksiwState();
}

class _TambahDataTransaksiwState extends State<TambahDataTransaksiw> {
  String _baseUrl = "http://beranekaragam.com/akuntansi/pilihan1.php";
  String _baseUrl2 = "http://beranekaragam.com/akuntansi/pilihan2.php?";
  String _baseUrl3 = "http://beranekaragam.com/akuntansi/pilihan3.php?";

  String pilihan1,
      sub1,
      pilihan2,
      sub3,
      pilihan3,
      id_pilihan,
      keterangan,
      nominal;
  List<dynamic> table_satu = List();
  List<dynamic> table_dua = List();
  List<dynamic> table_tiga = List();

  final _key = new GlobalKey<FormState>();

  void _satu() async {
    final respose =
        await http.get(_baseUrl); //untuk melakukan request ke webservice
    var listData = jsonDecode(respose.body); //lalu kita decode hasil datanya
    setState(() {
      table_satu = listData; // dan kita set kedalam variable _dataProvince
    });
  }

  void _dua(value) async {
    final respose = await http.get(_baseUrl2 +
        'pilihan1=' +
        '$pilihan1'); //untuk melakukan request ke webservice
    var listData = jsonDecode(respose.body); //lalu kita decode hasil datanya
    setState(() {
      table_dua = listData; // dan kita set kedalam variable _dataProvince
    });
  }

  void _tiga(value) async {
    final respose = await http.get(_baseUrl3 +
        'pilihan1=' +
        '$pilihan1'); //untuk melakukan request ke webservice
    var listData = jsonDecode(respose.body); //lalu kita decode hasil datanya
    setState(() {
      table_tiga = listData; // dan kita set kedalam variable _dataProvince
    });
  }

  var _autovalidate = false;

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }

  String idUsers = "";

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      idUsers = preferences.getString("id");
    });
  }

  void save() async {
     http.post("http://beranekaragam.com/akuntansi/TambahDataTransaksi.php", body: {
      "jenisTransaksi": pilihan1,
      "pilihan1": pilihan2,
      "pilihan2": pilihan3,
      "keterangan": keterangan,
      "nominal": nominal,
      "idUsers": idUsers,
    });

    // final data = jsonDecode(response.body);
    // int value = data['value'];
    // String pesan = data['message'];
    // if (value == 1) {
    //   setState(() {
    //     // widget.reload();
    //     Navigator.pop(context);
    //     print(pesan);
    //     tampilToast(pesan);
    //   });
    // } else {
    //   print(pesan);
    //   tampilToast(pesan);
    // }
  }

  tampilToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _satu();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaksi Baru"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              _showAlertDialog();
            },
            icon: Icon(Icons.close)),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(right: 180, top: 30.0, bottom: 8),
                child: Text(
                  "INFO TRANSAKSI",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                height: 700,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 20),
                      child: Text(
                        "Jenis Akun",
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                    Form(
                      key: _key,
                      autovalidate: _autovalidate,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Text("Pilih Jenis Transaksi"),
                                value: pilihan1,
                                items: table_satu.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item['pilihan1']),
                                    value: item['pilihan1'],
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    pilihan1 = value;
                                    pilihan2 = null;
                                  });
                                  _dua(value);
                                  _tiga(value);
                                },
                                isExpanded: true,
                              ),
                            ),
                          ),
                          Divider(
                            height: 10,
                            thickness: 0.5,
                            color: Colors.black.withOpacity(0.3),
                            indent: 0,
                            endIndent: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20),
                            child: Text(
                              "Diterima dari",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Text("Pilih perkiraan"),
                                value: pilihan2,
                                items: table_dua.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item['pilihan2']),
                                    value: item['pilihan2'],
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    pilihan2 = value;
                                  });
                                },
                                isExpanded: true,
                              ),
                            ),
                          ),
                          Divider(
                            height: 10,
                            thickness: 0.5,
                            color: Colors.black.withOpacity(0.3),
                            indent: 0,
                            endIndent: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20),
                            child: Text(
                              "Disimpan ke",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Text("Simpan ke"),
                                value: pilihan3,
                                items: table_tiga.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item['pilihan3']),
                                    value: item['pilihan3'],
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    pilihan3 = value;
                                  });
                                },
                                isExpanded: true,
                              ),
                            ),
                          ),
                          Divider(
                            height: 10,
                            thickness: 0.5,
                            color: Colors.black.withOpacity(0.3),
                            indent: 0,
                            endIndent: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20),
                            child: Text(
                              "Keterangan",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20),
                            child: TextFormField(
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Silakan Keterangan";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (e) => keterangan = e,
                              decoration: InputDecoration(
                                  hintText: 'Input keterangan',
                                  enabledBorder: InputBorder.none,
                                  // border: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(3.0),
                                  // )
                                  ),
                            ),
                          ),
                          Divider(
                            height: 10,
                            thickness: 0.5,
                            color: Colors.black.withOpacity(0.3),
                            indent: 0,
                            endIndent: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20),
                            child: Text(
                              "Nominal",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Silakan Nominal";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (e) => nominal = e,
                              decoration: InputDecoration(
                                  hintText: 'Input jumlah transaksi',
                                  enabledBorder: InputBorder.none,
                                 ),
                            ),
                          ),
                          Divider(
                            height: 10,
                            thickness: 0.5,
                            color: Colors.black.withOpacity(0.3),
                            indent: 0,
                            endIndent: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 38.0),
                            child: Container(
                              alignment: Alignment.center,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                onPressed: () {
                                  check();
                                  Navigator.of(context).push(new MaterialPageRoute(
                                    builder: (BuildContext context) => new DataTransaksi2(),
                                  )
                                  );
                                },
                                color: Colors.lightBlueAccent,
                                textColor: Colors.white,
                                child: Text(
                                  "Simpan",
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _showAlertDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: new Text("Batal Membuat Transaksi"),
            content: new Text(
                "Apakah anda yakin untuk membatalkan membuat transaksi?"),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DataTransaksi2(),
                    ),
                  );
                },
                child: new Text('Ya'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: new Text('Tidak'),
              )
            ],
          );
        });
  }
}
