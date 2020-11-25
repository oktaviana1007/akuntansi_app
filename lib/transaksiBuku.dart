import 'dart:convert';
import 'dart:async';
import 'package:akuntansi_app/custom/datepicker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransaksiBuku extends StatefulWidget {
  @override
  _TransaksiBukuState createState() => _TransaksiBukuState();
}

class _TransaksiBukuState extends State<TransaksiBuku> {
  var _disimpan = ['Kas', 'Bank', 'Perlengkapan', 'Persediaan', 'Sewa'];
  var _currentItemSelectedSimpan = 'Kas';
  String _mySelection;

  List data = List();

  String token;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      print("data : $token");
    });
  }

  //  Future<String> getSWData() async {
  //     var res = await http.get(Uri.encodeFull(url),
  //     headers: {"Accept": "application/json",
  //     'Authorization': 'Bearer $token'});
  //    Map<String, dynamic> map = json.decode(res.body);
  //    List<dynamic> dataa = map["data"];

  //   setState(() {
  //     data = dataa;
  //   });

  //   print(dataa);

  //   return "Sucess";
  // }
  int _valJenis;
  List<dynamic> _dataJenis = List();
  String baseUrl = "http://34.87.189.146:8000/api/jenistransaksi";
  final key =
      'GEkOo6sFgqDia4EfVarRMu73Vh6d5qwMfl5XtXn6sD3OiuKEXIZ7wIQ2C1tKFQUBpGDBIDGtsiLCedHN';
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

  @override
  void initState() {
    super.initState();
    getPref();
    getJenis();
    // this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Transaksi Baru'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: null)
        ],
        leading: IconButton(
          onPressed: () {
            _showAlertDialog();
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Padding(
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
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                     right: 10, bottom: 10),
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: 'Input Keterangan',
                                      hintStyle: TextStyle(fontSize: 15.0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue[200],
                          ),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text("Perkiraan"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 90.0),
                                child: Text("Debet"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50.0),
                                child: Text("Kredit"),
                              ),
                            ],
                          )),
                      FittedBox(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left : 10.0),
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
                                    print(val);
                                  });
                                },
                                // isExpanded: true,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 16.0, left: 10),
                              child: Container(
                                width: 90,
                                child: new Flexible(
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 18),
                                    decoration: InputDecoration(
                                        hintText: '0',
                                        hintStyle: TextStyle(fontSize: 15.0),
                                        contentPadding:
                                            EdgeInsets.only(left: 8)),
                                    // inputFormatters: [
                                    //   WhitelistingTextInputFormatter.digitsOnly,
                                    //   CurrencyFormat(),
                                    // ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 16, left: 10.0, right: 8),
                              child: Container(
                                width: 90,
                                child: new Flexible(
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 18),
                                    decoration: InputDecoration(
                                        hintText: '0',
                                        hintStyle: TextStyle(fontSize: 15.0),
                                        contentPadding:
                                            EdgeInsets.only(left: 8)),
                                    // inputFormatters: [
                                    //   WhitelistingTextInputFormatter.digitsOnly,
                                    //   CurrencyFormat(),
                                    // ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right :8.0),
                              child: Icon(Icons.close),
                            )
                          ],
                        ),
                      ),
                      FittedBox(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left : 10.0),
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
                                    print(val);
                                  });
                                },
                                // isExpanded: true,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 16.0, left: 10),
                              child: Container(
                                width: 90,
                                child: new Flexible(
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 18),
                                    decoration: InputDecoration(
                                        hintText: '0',
                                        hintStyle: TextStyle(fontSize: 15.0),
                                        contentPadding:
                                            EdgeInsets.only(left: 8)),
                                    // inputFormatters: [
                                    //   WhitelistingTextInputFormatter.digitsOnly,
                                    //   CurrencyFormat(),
                                    // ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 16, left: 10.0, right: 8),
                              child: Container(
                                width: 90,
                                child: new Flexible(
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 18),
                                    decoration: InputDecoration(
                                        hintText: '0',
                                        hintStyle: TextStyle(fontSize: 15.0),
                                        contentPadding:
                                            EdgeInsets.only(left: 8)),
                                    // inputFormatters: [
                                    //   WhitelistingTextInputFormatter.digitsOnly,
                                    //   CurrencyFormat(),
                                    // ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right :8.0),
                              child: Icon(Icons.close),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10.0),
            child: InkWell(
              child: Container(
                // width: ScreenUtil.getInstance().setWidth(330),
                height: ScreenUtil.getInstance().setHeight(90),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(1.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF6078ea).withOpacity(.3),
                          offset: Offset(0.0, 8.0),
                          blurRadius: 8.0)
                    ]),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => Transaksi(),
                    //     ),
                    //   );
                    // },
                    child: Center(
                      child: Text("SIMPAN",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Product-Bold",
                              fontSize: 18,
                              letterSpacing: 1.0)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAlertDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Batal Membuat Transaksi"),
            content: new Text(
                "Apakah anda yakin untuk membatalkan membuat transaksi?"),
            actions: <Widget>[
              // new FlatButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => Transaksi(),
              //       ),
              //     );
              //   },
              //   child: new Text('Ya'),
              // ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: new Text('Tidak'),
              )
            ],
          );
        });
  }
}
