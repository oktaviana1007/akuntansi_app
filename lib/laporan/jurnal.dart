// import 'package:akuntansi2/modal/filter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Jurnal extends StatefulWidget {
  @override
  _JurnalState createState() => _JurnalState();
}

class _JurnalState extends State<Jurnal> {
  String month;
  String year;
  setup() async {
    var tgl = new DateTime.now();
    var bln = tgl.month;
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
    // month = "September";
    year = "2020";
  }

  String token;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      print("data : $token");
    });
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

  List listYear = ["2018", "2019", "2020"];
  var loading = false;
  // var a;
  var b;
  Future getData() async {
    String apiURL = "http://34.87.189.146:8000/api/report/jurnal/view";
    var data = await http.post(apiURL, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      "month": "$month",
      "year": "$year"
    });

    var jsonData = json.decode(data.body);
    print(jsonData);
    print(data.statusCode);
    return jsonData;
  }

  @override
  void initState() {
    super.initState;
    setup();
    setState(() {
      getData();
    });
    getPref();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Laporan Jurnal"),
        centerTitle: true,
      ),
      body: loading ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text('Belum ada transaksi yang dibuat :)')],
            ))
          : SingleChildScrollView(
              child: Container(
          // padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Container(
                child: FittedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 12.0,left: 30),
                        child: Container(
                          padding: EdgeInsets.only(right: 20.0, left: 20.0),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black38, width: 1.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
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
                            const EdgeInsets.only(top: 12.0, right: 30.0, left: 10, bottom: 10),
                        child: Container(
                          padding: EdgeInsets.only(right: 20.0, left: 20.0),
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
              ),
              Table(
                border: TableBorder(
                    horizontalInside: BorderSide(
                        width: 0.5,
                        color: Colors.black,
                        style: BorderStyle.solid)),
                columnWidths: {
                  0: FixedColumnWidth(60),
                  1: FixedColumnWidth(170),
                  2: FixedColumnWidth(70),
                  3: FixedColumnWidth(65)
                },
                children: [
                  TableRow(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      children: [
                        Column(children: [
                          Container(
                            padding: EdgeInsets.all(7),
                          ),
                          Text("Tanggal",
                              style: TextStyle(
                                  fontFamily: "Product-Bold",
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5)),
                          Container(
                            padding: EdgeInsets.all(7),
                          )
                        ]),
                        Column(children: [
                          Container(
                            padding: EdgeInsets.all(7),
                          ),
                          Text("Keterangan",
                              style: TextStyle(
                                  fontFamily: "Product-Bold",
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5))
                        ]),
                        Column(children: [
                          Container(
                            padding: EdgeInsets.all(7),
                          ),
                          Text("Debit",
                              style: TextStyle(
                                  fontFamily: "Product-Bold",
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5))
                        ]),
                        Column(children: [
                          Container(
                            padding: EdgeInsets.all(7),
                          ),
                          Text("Kredit",
                              style: TextStyle(
                                  fontFamily: "Product-Bold",
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5))
                        ]),
                      ])
                ],
              ),
              FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  
                  // final a = snapshot.data['data'][month];
                  if (snapshot.connectionState != ConnectionState.done)
                    return Center(child: CircularProgressIndicator());
                  if (!snapshot.hasData || snapshot.data == null)
                    return Container();
                  if (snapshot.data.isEmpty)
                    return Container();
                    
                  if (snapshot.hasData) {
                    final a = snapshot.data['data'];
                    if(a == null){
                      return Container();
                    }else{
                      final a = snapshot.data['data'][month];
                      return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          // scrollDirection: Axis.vertical,
                          itemCount: a.length == null
                              ? 0 : a.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            // final a = snapshot.data['data'][month];
                            return Table(
                              border: TableBorder(
                                  horizontalInside: BorderSide(
                                      width: 0.5,
                                      color: Colors.black,
                                      style: BorderStyle.solid)),
                              columnWidths: {
                                0: FixedColumnWidth(80),
                                1: FixedColumnWidth(150),
                                2: FixedColumnWidth(65),
                                3: FixedColumnWidth(60)
                              },
                              children: [
                                TableRow(
                                    decoration:
                                        BoxDecoration(color: Colors.grey[200]),
                                    children: [
                                      Column(children: [
                                        Text(""),
                                        Container(
                                          padding: EdgeInsets.all(7),
                                        )
                                      ]),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(7),
                                            ),
                                            Text(
                                                (a[index]['nama_transaksi'])
                                                    .toString(), textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: "Product-Bold",
                                                    fontSize: 13,
                                                    letterSpacing: 0.5)),
                                            Container(
                                              padding: EdgeInsets.all(7),
                                            ),
                                          ]),
                                      Column(children: [Text((" "))]),
                                      Column(children: [Text((" "))]),
                                    ]),
                                TableRow(children: [
                                  Column(children: [
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    ),
                                    Text(a[index]['tanggal'],
                                        style: TextStyle(
                                            fontFamily: "Product-Bold",
                                            fontSize: 11,
                                            letterSpacing: 0.5)),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    )
                                  ]),
                                  Column(children: [
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                          (a[index]['jurnal_detail'][1]
                                              ['perkiraan']),
                                          style: TextStyle(
                                              fontFamily: "Product-Bold",
                                              fontSize: 13,
                                              letterSpacing: 0.5)),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    )
                                  ]),
                                  Column(children: [
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    ),
                                    Text(
                                        (a[index]['jurnal_detail'][1]['jumlah'])
                                            .toString(),
                                        style: TextStyle(
                                            fontFamily: "Product-Bold",
                                            fontSize: 12,
                                            letterSpacing: 0.5)),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    ),
                                  ]),
                                  Column(children: [
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    ),
                                    Text("0",
                                        style: TextStyle(
                                            fontFamily: "Product-Bold",
                                            fontSize: 12,
                                            letterSpacing: 0.5)),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    )
                                  ]),
                                ]),
                                TableRow(children: [
                                  Column(children: [
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    ),
                                    Text(a[index]['tanggal'],
                                        style: TextStyle(
                                            fontFamily: "Product-Bold",
                                            fontSize: 11,
                                            letterSpacing: 0.5)),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    )
                                  ]),
                                  Column(children: [
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    ),
                                    Container(
                                      
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                          (a[index]['jurnal_detail'][0]
                                              ['perkiraan']),
                                          style: TextStyle(
                                              fontFamily: "Product-Bold",
                                              fontSize: 13,
                                              letterSpacing: 0.5)),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    ),
                                  ]),
                                  Column(children: [
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    ),
                                    Text("0",
                                        style: TextStyle(
                                            fontFamily: "Product-Bold",
                                            fontSize: 12,
                                            letterSpacing: 0.5)),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    ),
                                  ]),
                                  Column(children: [
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    ),
                                    Text(
                                        (a[index]['jurnal_detail'][0]['jumlah'])
                                            .toString(),
                                        style: TextStyle(
                                            fontFamily: "Product-Bold",
                                            fontSize: 12,
                                            letterSpacing: 0.5)),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    ),
                                  ]),
                                ])
                              ],
                            );
                          },
                        ),
                        Table(
                          border: TableBorder(
                              horizontalInside: BorderSide(
                                  width: 0.5,
                                  color: Colors.black,
                                  style: BorderStyle.solid)),
                          columnWidths: {
                            0: FixedColumnWidth(80),
                            1: FixedColumnWidth(150),
                            2: FixedColumnWidth(53),
                            3: FixedColumnWidth(80)
                          },
                          children: [
                            TableRow(
                                decoration:
                                    BoxDecoration(color: Colors.grey[200]),
                                children: [
                                  Column(children: [
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    ),
                                    Text("Total",
                                        style: TextStyle(
                                            fontFamily: "Product-Bold",
                                            fontSize: 13,
                                            letterSpacing: 0.5)),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    ),
                                  ]),
                                  Column(children: [
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    ),
                                    Text("",
                                        style: TextStyle(
                                            fontFamily: "Product-Bold",
                                            fontSize: 13,
                                            letterSpacing: 0.5)),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    ),
                                  ]),
                                  Column(children: [
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    ),
                                    Text(snapshot.data['totaldebit'].toString(),
                                        style: TextStyle(
                                            fontFamily: "Product-Bold",
                                            fontSize: 12,
                                            letterSpacing: 0.5)),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    ),
                                  ]),
                                  Column(children: [
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    ),
                                    Text(
                                        snapshot.data['totalkredit'].toString(),
                                        style: TextStyle(
                                            fontFamily: "Product-Bold",
                                            fontSize: 12,
                                            letterSpacing: 0.5)),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                    ),
                                  ]),
                                ])
                          ],
                        ),
                      ],
                    );
                    }
                    
                  }{
                    
                  } 
                  }
              )
            ],
          ),
        ),
      ),
    );
  }

  // void _showAlertDialog() {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return FittedBox(
  //           child: AlertDialog(
  //             title: Text("Filter Tanggal"),
  //             content: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 FilterAwal(),
  //                 Padding(
  //                   padding: const EdgeInsets.only(
  //                       right: 150, top: 20.0, bottom: 20.0),
  //                   child: Text(
  //                     "sampai dengan",
  //                     style: TextStyle(color: Colors.black54),
  //                   ),
  //                 ),
  //                 FilterAwal()
  //               ],
  //             ),
  //             actions: <Widget>[
  //               Container(
  //                 padding: EdgeInsets.only(right: 115),
  //                 child: FlatButton(
  //                   shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(8.0)),
  //                   color: Colors.blue,
  //                   child: Text("FILTER"),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }
}
