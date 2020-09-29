import 'dart:convert';
import 'package:akuntansi_app/API.dart';
import 'package:akuntansi_app/DetailTransaksi.dart';
import 'package:akuntansi_app/TambahDataTransaksi.dart';
import 'package:akuntansi_app/mainDrawer.dart';
import 'package:akuntansi_app/model/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DataTransaksi extends StatefulWidget {
  @override
  _DataTransaksiState createState() => _DataTransaksiState();
}

class _DataTransaksiState extends State<DataTransaksi> {
  String month;
  String year;
  setup() async {
    month = "September";
    year = "2020";
  }

  List listMonth = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "Oktober",
    "November",
    "Desember"
  ];

  List listYear = ["2018", "2019", "2020"];
  String token;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
    });

    setup();
    _lihatData();
  }

  var loading = false;
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  List<Datas> _list = [];
  var _search;
  Future<List<Datas>> _lihatData() async {
    _list.clear();
    final response = await http.post(BaseUrl.APIdataTransaksi, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      "month": "$month",
      "year": "$year"
    });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var i in data) {
        Datas dat = Datas(i["tanggal"], i["keterangan"], i["jumlah"],
            i["perkiraan1"], i["perkiraan2"]);
        _list.add(dat);
      }
      print(_list.length);
      return _list;
    }
    // _list = json.decode(response.body);
    // print(response.statusCode);
    // return jsonData;
  }

// TextEditingController controller = new TextEditingController();

//   onSearch(String text) async {
//     _search.clear();
//     if (text.isEmpty) {
//       setState(() {});
//       return;
//     }

//     list.forEach((f) {
//       if (f.title.contains(text) || f.id.toString().contains(text))
//         _search.add(f);
//     });

//     setState(() {});
//   }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {
    //   _lihatData();
    // });
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaksi'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      drawer: MainDrawer(),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => TambahDataTransaksi()));
        },
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40), color: Colors.blue),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 25,
          ),
        ),
      ),
      body: loading
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text('Belum ada transaksi yang dibuat :)')],
            ))
          : Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, left: 40.0),
                        child: Container(
                          padding: EdgeInsets.only(left: 12.0, right: 12.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black38, width: 1.0),
                              borderRadius: BorderRadius.circular(5.0)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text("Pilih Bulan"),
                              value: month,
                              items: listMonth.map((value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  this.month = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 12.0, right: 40.0),
                        child: Container(
                          padding: EdgeInsets.only(right: 12.0, left: 12.0),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black38, width: 1.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text("Pilih Tahun"),
                              value: year,
                              items: listYear.map((value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  year = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Container(
                    width: double.infinity,
                    height: 57,
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
                    child: TextField(
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        labelStyle:
                            TextStyle(fontSize: 15.0, color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        prefixIcon: Icon(Icons.search, size: 20.0),
                        hintText: 'Pencarian',
                        filled: true,
                        fillColor: Colors.blue[100],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: _lihatData(),
                    builder: (context, snapshot) {
                      print(snapshot.data);
                      if (snapshot.data == null) {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data == null
                              ? 0
                              : snapshot.data.length,
                          itemBuilder: (context, i) {
                            final c = snapshot.data;
                            return new Container(
                              padding: const EdgeInsets.all(5.0),
                              child: new GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            DetailTransaksi(c[i]))),
                                child: new Card(
                                  elevation: 2.0,
                                  child: Container(
                                    width: double.infinity,
                                    height: 75,
                                    decoration: BoxDecoration(
                                          color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
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
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: <Widget>[
                                        ListTile(
                                          title: new Text(
                                            c[i].keterangan,
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          trailing: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 35.0),
                                            child: new Text(
                                              c[i].jumlah.toString(),
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          subtitle: new Text(
                                            c[i].tanggal.toString(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                )
              ],
            ),
    );
  }
}
