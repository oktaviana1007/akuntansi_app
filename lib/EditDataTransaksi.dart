import 'dart:convert';
import 'package:akuntansi_app/API.dart';
import 'package:akuntansi_app/DataTransaksi.dart';
import 'package:akuntansi_app/model/data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class EditDataTransaksi extends StatefulWidget {
  // List list;
  // int index;
  // EditDataTransaksi({this.index, this.list});
  final Datas list;

  EditDataTransaksi(this.list);
  // final jenisTransaksiModel model;
  // final VoidCallback reload;
  // EditDataTransaksi(this.model, this.reload);
  @override
  _EditDataTransaksiState createState() => _EditDataTransaksiState();
}

class _EditDataTransaksiState extends State<EditDataTransaksi> {
  final _key = new GlobalKey<FormState>();
  String jenisTransaksi, pilihan1, pilihan2, keterangan, nominal;

  TextEditingController txtjenisTransaksi;
  TextEditingController txtpilihan1;
  TextEditingController txtpilihan2;
  TextEditingController txtketerangan;
  TextEditingController txtnominal;

  // check() {
  //   final form = _key.currentState;
  //   if (form.validate()) {
  //     form.save();
  //     submit();
  //   } else {}
  // }

  // String id;

  // getPref()async{
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     id = preferences.getString("id");
  //   });
  // }

  void submit() {
    http.post(BaseUrl.APIeditDataTransaksi, body: {
      "jenisTransaksi": pilihan1,
      "pilihan1": pilihan2,
      "pilihan2": pilihan3,
      "keterangan": txtketerangan.text,
      "nominal": txtnominal.text,
      // "id": widget.list[widget.index]['id'],
    });
  }

  tampilToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.orange,
        textColor: Colors.white);
  }

  String _baseUrl = "http://beranekaragam.com/akuntansi/pilihan1.php";
  String _baseUrl2 = "http://beranekaragam.com/akuntansi/pilihan2.php?";
  String _baseUrl3 = "http://beranekaragam.com/akuntansi/pilihan3.php?";

  String sub1, sub3, pilihan3, id_pilihan, idUsers;

  List<dynamic> table_satu = List();
  List<dynamic> table_dua = List();
  List<dynamic> table_tiga = List();

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

  @override
  void initState() {
    // TODO: implement initState
    txtjenisTransaksi = new TextEditingController(
        text: widget.list.perkiraan2);
    txtpilihan1 =
        new TextEditingController(text: widget.list.perkiraan2);
    txtpilihan2 =
        new TextEditingController(text: widget.list.perkiraan2);
    txtketerangan = new TextEditingController(
        text: widget.list.keterangan);
    txtnominal =
        new TextEditingController(text: widget.list.jumlah.toString());
    super.initState();
    _satu();
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
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: DropdownButtonHideUnderline(
                                                      child: DropdownButton(
                              hint: Text("Jenis Transaksi"),
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
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: DropdownButtonHideUnderline(
                                                      child: DropdownButton(
                              hint: Text("Diterima Dari"),
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
                              "Simpan ke",
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
                          padding: const EdgeInsets.only(left: 20),
                          child: new TextField(
                            controller: txtketerangan,
                            decoration: new InputDecoration(
                                enabledBorder: InputBorder.none,),
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
                            controller: txtnominal,
                            decoration: new InputDecoration(
                                enabledBorder: InputBorder.none,),
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
                          child: ButtonTheme(
                            minWidth: MediaQuery.of(context).size.width,
                            child: new Container(
                              child: new RaisedButton(
                                onPressed: () {
                                  submit();
                                  Navigator.of(context).push(new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new DataTransaksi()));
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
