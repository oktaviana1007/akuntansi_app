import 'dart:convert';
import 'package:akuntansi_app/API.dart';
import 'package:akuntansi_app/DataTransaksi.dart';
import 'package:akuntansi_app/datatransaksi2.dart';
import 'package:akuntansi_app/model/data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditDataTransaksi extends StatefulWidget {
  final Datas list;

  EditDataTransaksi(this.list);
  @override
  _EditDataTransaksiState createState() => _EditDataTransaksiState();
}

class _EditDataTransaksiState extends State<EditDataTransaksi> {
  final _key = new GlobalKey<FormState>();
  String jenisTransaksi, pilihan1, pilihan2, keterangan, jumlah;
  TextEditingController txtjenisTransaksi;
  TextEditingController txtpilihan1;
  TextEditingController txtpilihan2;
  TextEditingController txtketerangan;
  TextEditingController txtjumlah;

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit();
    } else {}
  }

  String token;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      print("data : $token");
    });
  }

  void submit() async {
    var response = await http.post(BaseUrl.editDataTransaksi, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      "jenis_transaksi": _valJenis.toString(),
      "pilihan1": _valKredi.toString(),
      "pilihan2": _valPerki.toString(),
      "keterangan": txtketerangan.text,
      "tanggal": "$date",
      "nominal": txtjumlah.text,
      "id": widget.list.id_transaksi.toString(),
    });
    final data = jsonDecode(response.body);
    bool value = data['success'];
    String message = data['message'];
    if (value == true) {
      setState(() {
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new DataTransaksi2()));
        print(data);
        // print(token);
        // Navigator.pop(context);
        // _lihatData();
        tampilToast("Transaksi berhasil diedit");
      });
    } else {
      // print(token);
      tampilToast("Harap isi kembali semua field!");
      // print("");
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

  String baseUrl = "http://34.87.189.146:8000/api/jenistransaksi";
  String baseUrl2 = "http://34.87.189.146:8000/api/mapping/debit";
  String baseUrl3 = "http://34.87.189.146:8000/api/mapping/kredit";

  int _valJenis, _valKredi, _valPerki;
  String perki1, perki2, jenis;
  List<dynamic> _dataJenis = List();
  List<dynamic> _dataPerki = List();
  List<dynamic> _dataKredi = List();

  final key =
      'GEkOo6sFgqDia4EfVarRMu73Vh6d5qwMfl5XtXn6sD3OiuKEXIZ7wIQ2C1tKFQUBpGDBIDGtsiLCedHN';
  void getJenis() async {
    await http.get(baseUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $key'
    }).then((response) {
      var map = json.decode(response.body);
      print(map);
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

  // String pilihTanggal, labelText;
  // DateTime tgl = new DateTime.now();
  // final TextStyle valueStyle = TextStyle(fontSize: 16.0);
  // Future<Null> _selectedDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: tgl,
  //       firstDate: DateTime(1992),
  //       lastDate: DateTime(2099));

  //   if (picked != null && picked != tgl) {
  //     setState(() {
  //       tgl = picked;
  //       pilihTanggal = new DateFormat.yMd().format(tgl);
  //     });
  //   } else {}
  // }

  final TextEditingController controllerDate = TextEditingController();

  DateTime date;

  @override
  void initState() {
    // TODO: implement initState
    jenis = widget.list.jenis_transaksi;
    perki1 = widget.list.perkiraan1;
    perki2 = widget.list.perkiraan2;
    print("id : $perki1");
    // _valKredi = widget.list.perkiraan2_id;
    // _valPerki = widget.list.perkiraan1_id;
    date = DateFormat('yyyy-MM-dd').parse(widget.list.tanggal);
    controllerDate.text = widget.list.tanggal;
    txtjenisTransaksi = new TextEditingController(text: widget.list.perkiraan2);
    txtpilihan1 = new TextEditingController(text: widget.list.perkiraan2);
    txtpilihan2 = new TextEditingController(text: widget.list.perkiraan2);
    txtketerangan = new TextEditingController(text: widget.list.keterangan);
    txtjumlah = new TextEditingController(text: widget.list.jumlah.toString());
    super.initState();
    getPref();
    getJenis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Transaksi'),
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
                                hint: Text(
                                  jenis,
                                  style: TextStyle(color: Colors.black),
                                ),
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
                                    // print(val);
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
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 20),
                          //   child: DateDropDown(
                          //     labelText: labelText,
                          //     valueText: new DateFormat.yMd().format(tgl),
                          //     valueStyle: valueStyle,
                          //     onPressed: () {
                          //       _selectedDate(context);
                          //     },
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, left: 20),
                            child: TextField(
                              controller: controllerDate,
                              decoration: InputDecoration(
                                // labelText: 'Date',
                                border: InputBorder.none,
                                // suffixIcon: Column(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: <Widget>[
                                //     Icon(Icons.today),
                                //   ],
                                // ),
                              ),
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.blue),
                              readOnly: true,
                              onTap: () async {
                                DateTime datePicker = await showDatePicker(
                                  context: context,
                                  initialDate: date,
                                  firstDate: DateTime(2019),
                                  lastDate: DateTime(2030),
                                );
                                date = datePicker;
                                controllerDate.text =
                                    DateFormat('yyyy-MM-dd').format(date);
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
                                hint: Text(
                                  perki2,
                                  style: TextStyle(color: Colors.black),
                                ),
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
                              "Simpan ke",
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
                                hint: Text(
                                  perki1,
                                  style: TextStyle(color: Colors.black),
                                ),
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
                            padding: const EdgeInsets.only(left: 20),
                            child: new TextField(
                              controller: txtketerangan,
                              decoration: new InputDecoration(
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
                            padding: const EdgeInsets.only(left: 20),
                            child: new TextField(
                              controller: txtjumlah,
                              decoration: new InputDecoration(
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
                            padding: const EdgeInsets.only(top: 15.0),
                            child: ButtonTheme(
                              minWidth: MediaQuery.of(context).size.width,
                              child: new Container(
                                child: new RaisedButton(
                                  onPressed: () {
                                    submit();
                                  },
                                  textColor: Colors.white,
                                  child: Text(
                                    "Simpan",
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
