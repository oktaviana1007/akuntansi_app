import 'dart:async';
import 'dart:convert';
import 'package:akuntansi_app/API.dart';
import 'package:akuntansi_app/DetailTransaksi.dart';
import 'package:akuntansi_app/TambahDataTransaksi.dart';
import 'package:akuntansi_app/mainDrawer.dart';
import 'package:akuntansi_app/model/data.dart';
import 'package:akuntansi_app/transaksiBuku.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class DataTransaksi2 extends StatefulWidget {
  @override
  _DataTransaksi2State createState() => _DataTransaksi2State();
}

class _DataTransaksi2State extends State<DataTransaksi2> {
    String month;
    String year;

  setup() async {
    var tgl = new DateTime.now();
    var thn = tgl.year;
    var bln = tgl.month;
    if (thn == 2020){
      year = "2020";
    }
    if (thn == 2021) {
      year = "2021";
    }
    if (thn == 2022) {
      year = "2022";
    }
    if (thn == 2023) {
      year = "2023";
    }
    if (bln == 1) {
      month = "January";
    }
    if (bln == 2) {
      month = "February";
    }
    if (bln == 3) {
      month = "March";
    }
    if (bln == 4) {
      month = "April";
    }
    if (bln == 5) {
      month = "May";
    }
    if (bln == 6) {
      month = "June";
    }
    if (bln == 7) {
      month = "July";
    }
    if (bln == 8) {
      month = "August";
    }
    if (bln == 9) {
      month = "September";
    }
    if (bln == 10) {
      month = "October";
    }
    if (bln == 11) {
      month = "November";
    }
    if (bln == 12) {
      month = "December";
    }
    // year = "2020";
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
    "October",
    "November",
    "December"
  ];

  List listYear = ["2018", "2019", "2020", "2021","2022", "2023"];
  String token;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
    });
    setup();
    DataConnectionStatus status = await check();
    if (status == DataConnectionStatus.disconnected) {
     showDialog(
       context: context,
        barrierDismissible: true,
        builder: (_) {
          new AlertDialog(
          title: Text("Tidak ada koneksi"),
          content: Text("Periksa kembali koneksi anda"),
        );
        }
      );
    }else{
    _lihatData();
    }
  }

  var loading = false;
  // final GlobalKey<RefreshIndicatorState> _refresh =
  //     GlobalKey<RefreshIndicatorState>();
  List<Datas> _list = [];
  List<Datas> _search = [];

  

  Future<List<Datas>> _lihatData() async {
    _list.clear();

    
    final response = await http.post(BaseUrl.dataTransaksi, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      "month": "$month",
      "year": "$year"
    });
      if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var i in data) {
        Datas dat = Datas(
            i["tanggal"],
            i["keterangan"],
            i["jumlah"],
            i["perkiraan1"],
            i["perkiraan2"],
            i["id_transaksi"],
            i["jenis_transaksi"],
            i["perkiraan1_id"],
            i["perkiraan2_id"],
            i["jenis_transaksi_id"]);
        _list.add(dat);
      }
      print(_list);
      return _list;
    }
     
    
  }

  TextEditingController controller = new TextEditingController();

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _list.forEach((f) {
      if (f.keterangan.contains(text)) _search.add(f);
    });

    setState(() {});
  }

  StreamSubscription<DataConnectionStatus> listener;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    listener.cancel();
    super.dispose();
  }

   check() async {
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          print('Data connection is available.');
          break;
        case DataConnectionStatus.disconnected:
          print('You are disconnected from the internet.');
          break;
      }
    });

    return await DataConnectionChecker().connectionStatus;
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
      floatingActionButton: SpeedDial(
        curve: Curves.bounceOut,
        animatedIcon: AnimatedIcons.menu_close,
        overlayColor: Colors.black12,
        backgroundColor: Colors.blue,
        children: [
          SpeedDialChild(
              child: Icon(
                Icons.book,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              label: "Dengan Pembukuan",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransaksiBuku(),
                  ),
                );
              }),
          SpeedDialChild(
            child: Icon(
              Icons.bookmark,
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            label: "Langsung",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TambahDataTransaksi(),
                ),
              );
            },
          ),
        ],
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
                              border:
                                  Border.all(color: Colors.black38, width: 1.0),
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
                        padding: const EdgeInsets.only(top: 12.0, right: 40.0),
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
                      controller: controller,
                      onChanged: onSearch,
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
                  child:  _search.length != 0 || controller.text.isNotEmpty
                      ? ListView.builder(
                          itemCount: _search.length,
                          itemBuilder: (context, i) {
                            final c = _search[i];
                            return new Container(
                              padding: const EdgeInsets.all(5.0),
                              child: new GestureDetector(
                                // onTap: () => Navigator.push(
                                //     context,
                                //     new MaterialPageRoute(
                                //         builder: (context) =>
                                //             DetailTransaksi(c[i]))),
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
                                            c.keterangan,
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          trailing: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 35.0),
                                            child: new Text(
                                              c.jumlah.toString(),
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          subtitle: new Text(
                                            c.tanggal.toString(),
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
                        )
                      : FutureBuilder(
                          future: _lihatData(),
                          builder: (context, snapshot) {
                            // print(snapshot.data);
                            if (snapshot.data == null) {
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, i) {
                                  final c = snapshot.data;
                                  int d = c[i].jenis_transaksi_id;
                                  Color getColor(int d){
                                  int d = c[i].jenis_transaksi_id;
                                    if ( d == 1 || d == 3){
                                      return Colors.green;
                                    }else{
                                      return Colors.blue;
                                    }
                                  }
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
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                                trailing: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 35.0),
                                                  child: new Text(
                                                    c[i].jumlah.toString(),
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ),
                                                subtitle: new Text(
                                                  c[i].tanggal.toString(),
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                
                                                leading: Container(
                                                  width: 20,
                                                  height: 70,
                                                  decoration: BoxDecoration(
                                                      color: getColor(d)),
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
