import 'dart:convert';
import 'package:akuntansi_app/API.dart';
import 'package:akuntansi_app/DataTransaksi.dart';
import 'package:akuntansi_app/datatransaksi2.dart';
import 'package:akuntansi_app/Pengaturan.dart';
import 'package:akuntansi_app/custom/datepicker.dart';
import 'package:akuntansi_app/model/jenisTransaksi.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TambahDataTransaksi extends StatefulWidget {
  @override
  _TambahDataTransaksiState createState() => _TambahDataTransaksiState();
}

class _TambahDataTransaksiState extends State<TambahDataTransaksi> {
  String baseUrl = "http://34.87.189.146:8000/api/jenistransaksi";
  String baseUrl2 = "http://34.87.189.146:8000/api/mapping/debit";
  String baseUrl3 = "http://34.87.189.146:8000/api/mapping/kredit";

  String keterangan, nominal;

  final key =
      'GEkOo6sFgqDia4EfVarRMu73Vh6d5qwMfl5XtXn6sD3OiuKEXIZ7wIQ2C1tKFQUBpGDBIDGtsiLCedHN';
  int _valJenis, _valKredi, _valPerki;

  List<dynamic> _dataJenis = List();
  List<dynamic> _dataPerki = List();
  List<dynamic> _dataKredi = List();

  final _key = new GlobalKey<FormState>();

  String token;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
    });
    // print(idUsers);
  }

  // List<JenisTransaksi> listModel = [];
  // Future<Null> getData() async {
  //   final responseData = await http.get(baseUrl, headers: {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $key'
  //   });
  //   if (responseData.statusCode == 200) {
  //     final data = jsonDecode(responseData.body);
  //     print("data : $data");
  //     // return data;
  //     setState(() {
  //       for (Map i in data["data"]) {
  //         listModel.add(JenisTransaksi.fromJson(i));
  //       }
  //     });
  //   }
  // }

  void getJenis() async {
    await http.get(baseUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $key'
    }).then((response) {
      var map = json.decode(response.body);
      // print(map);
      setState(() {
        _dataJenis = map['data'];
      });
    });
  }

  void getDebit(int id) async {
    await http.get(baseUrl2 + '/$id', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $key'
    }).then((response) {
      var map = json.decode(response.body);
      // print(map);
      setState(() {
        _dataPerki = map['data'];
      });
    });
  }

  void getKredit(int id) async {
    await http.get(baseUrl3 + '/$id', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $key'
    }).then((response) {
      var map = json.decode(response.body);
      // print(map);
      setState(() {
        _dataKredi = map['data'];
      });
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

  String pilihTanggal, labelText;
  DateTime tgl = new DateTime.now();
  final TextStyle valueStyle = TextStyle(fontSize: 16.0);
  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: tgl,
        firstDate: DateTime(1992),
        lastDate: DateTime(2099));

    if (picked != null && picked != tgl) {
      setState(() {
        tgl = picked;
        pilihTanggal = new DateFormat.yMd().format(tgl);
      });
    } else {}
  }

  void save() async {
    final response = await http.post(BaseUrl.tambahDataTransaksi, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      "tanggal": "$tgl",
      "transaksi_id": _valJenis.toString(),
      "perkiraan1_id": _valKredi.toString(),
      "perkiraan2_id": _valPerki.toString(),
      "keterangan": keterangan,
      "jumlah": nominal.toString(),
    });

    final data = jsonDecode(response.body);
    // print(data);
    bool value = data['success'];

    // String pesan = data['message'];
    if (value == true) {
      setState(() {
        // widget.reload();
        // Navigator.pop(context);

        Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => DataTransaksi2(),
        ));
        print(data);
        tampilToast("Data Berhasil Ditambahkan");
      });
    } else {
      print(data);
      print(response.statusCode);
      tampilToast("Data GAGAL Ditambahkan, isi semua field");
    }
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
    _valJenis = 1;
    getJenis();
    getPref();
    // getData();
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
                                value: _valJenis,
                                items: _dataJenis.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item['jenis']),
                                    value: item['id'],
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    _valJenis = val;
                                    _valPerki = null;
                                    print(val);
                                  });
                                  getKredit(val);
                                  getDebit(val);
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
                              "Input Tanggal",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: DateDropDown(
                              labelText: labelText,
                              valueText: new DateFormat.yMd().format(tgl),
                              valueStyle: valueStyle,
                              onPressed: () {
                                _selectedDate(context);
                              },
                            ),
                          ),
                          Divider(
                            height: 10,
                            thickness: 0.5,
                            color: Colors.black.withOpacity(0.3),
                            indent: 0,
                            endIndent: 0,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 3.0, left: 6),
                          //   child: ListView.builder(
                          //       itemCount: listModel.length,
                          //       shrinkWrap: true,
                          //       itemBuilder: (context, index) {
                          //         final nDataList = listModel[index];
                          //         if (_valJenis == null) {
                          //           Text("data");
                          //         } else {
                          //           if (_valJenis == nDataList.data) {
                          //             return ListTile(
                          //                 title: Text(
                          //               "${nDataList.data}",
                          //               style: TextStyle(
                          //                 color: Colors.black38,
                          //                 fontSize: 13.0,
                          //               ),
                          //             ));
                          //           } else{
                          //             print("gagal");
                          //             return Container();
                          //           }
                          //         }
                          //       }),
                          // ),
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
                                hint: Text("Diterima dari"),
                                value: _valPerki,
                                items: _dataPerki.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item['nama_perkiraan']),
                                    value: item['id'],
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _valPerki = value;
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
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Text("Simpan ke"),
                                value: _valKredi,
                                items: _dataKredi.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item['nama_perkiraan']),
                                    value: item['id'],
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _valKredi = value;
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
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
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
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
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
                            padding:
                                const EdgeInsets.only(left: 100.0, top: 30),
                            child: Container(
                              height: 50,
                              width: 150,
                              child: ButtonTheme(
                                minWidth: MediaQuery.of(context).size.width,
                                child: new Container(
                                  child: new RaisedButton(
                                    onPressed: () {
                                      check();
                                    },
                                    child: Text(
                                      "SIMPAN",
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.white),
                                    ),
                                  ),
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
                      builder: (context) => Pengaturan(),
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
