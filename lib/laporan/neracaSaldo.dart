import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class NeracaSaldo extends StatefulWidget {
  @override
  _NeracaSaldoState createState() => _NeracaSaldoState();
}

class _NeracaSaldoState extends State<NeracaSaldo> {
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
    "October",
    "November",
    "December"
  ];

  List listYear = ["2018", "2019", "2020"];

  String token;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      print("data : $token");
    });
  }

  var a;
  var b;
  Future getData(String month, String year) async {
    // final prefs = await SharedPreferences.getInstance();
    //   final key = 'api_token';
    //   final value = prefs.get(key) ?? 0;
    //   print(value);
    String apiURL = "http://34.87.189.146:8000/api/report/neracasaldo/view";
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
    getPref();
    getData(month, year);
  }

  Widget tableitem(String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Text(
        value,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget coloredbox(Widget child,
          {bool top = false,
          bool bottom = false,
          bool right = false,
          bool left = false}) =>
      Container(
        decoration: BoxDecoration(
            border: Border(
          right: BorderSide(
              color: right ? Colors.black : Colors.transparent, width: 2),
          left: BorderSide(
              color: left ? Colors.black : Colors.transparent, width: 2),
          top: BorderSide(
              color: top ? Colors.black : Colors.transparent, width: 2),
          bottom: BorderSide(
              color: bottom ? Colors.black : Colors.transparent, width: 2),
        )),
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Neraca Saldo"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: FittedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, left: 30),
                      child: Container(
                        padding: EdgeInsets.only(right: 20.0, left: 20.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38, width: 1.0),
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
                      padding: const EdgeInsets.only(
                          top: 12.0, right: 30.0, left: 10, bottom: 30),
                      child: Container(
                        padding: EdgeInsets.only(right: 20.0, left: 20.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38, width: 1.0),
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
            Divider(
              height: 2,
              thickness: 1,
              color: Colors.black,
              indent: 0,
              endIndent: 0,
            ),
            Table(
              border: TableBorder(
                  verticalInside: BorderSide(
                      width: 1, color: Colors.black, style: BorderStyle.solid)),
              columnWidths: {
                0: FixedColumnWidth(150),
                1: FixedColumnWidth(90),
                2: FixedColumnWidth(90),
              },
              children: [
                TableRow(children: [
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Perkiraan",
                            style: TextStyle(
                                fontFamily: "Product-Bold",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5)),
                      ),
                    )
                  ]),
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Text("Debit",
                          style: TextStyle(
                              fontFamily: "Product-Bold",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5)),
                    )
                  ]),
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Text("Kredit",
                          style: TextStyle(
                              fontFamily: "Product-Bold",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5)),
                    )
                  ]),
                ])
              ],
            ),
            Divider(
              height: 2,
              thickness: 1,
              color: Colors.black,
              indent: 0,
              endIndent: 0,
            ),
            FutureBuilder(
              future: getData(month, year),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  a = snapshot.data['data'][month];
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                          itemCount: a.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Table(
                              border: TableBorder(
                                  verticalInside: BorderSide(
                                      width: 1,
                                      color: Colors.black,
                                      style: BorderStyle.solid)),
                              columnWidths: {
                                0: FixedColumnWidth(150),
                                1: FixedColumnWidth(90),
                                2: FixedColumnWidth(90),
                              },
                              children: [
                                TableRow(
                                    decoration:
                                        BoxDecoration(color: Colors.grey[200]),
                                    children: [
                                      Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              alignment: Alignment.topLeft,
                                              child:
                                                  Text(a[index]['perkiraan'])),
                                        )
                                      ]),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              alignment: Alignment.bottomRight,
                                              child: Text((a[index]['tipe'])
                                                          .toString() ==
                                                      "D"
                                                  ? (a[index]['jumlah'])
                                                      .toString()
                                                  : "0"),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0, left: 8, right: 20),
                                            child: Container(
                                              alignment: Alignment.bottomRight,
                                              child: Text((a[index]['tipe'])
                                                          .toString() ==
                                                      "D"
                                                  ? "0"
                                                  : (a[index]['jumlah'])
                                                      .toString()),
                                            ),
                                          )
                                        ],
                                      ),
                                    ])
                              ],
                            );
                          },
                        ),
                        Divider(
                          height: 2,
                          thickness: 1,
                          color: Colors.black,
                          indent: 0,
                          endIndent: 0,
                        ),
                        Table(
                          // border: TableBorder.all(),
                          columnWidths: {
                            0: FixedColumnWidth(150),
                            1: FixedColumnWidth(80),
                            2: FixedColumnWidth(85),
                          },
                          children: [
                            TableRow(children: [
                              Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Text("Total",
                                          style: TextStyle(
                                              fontFamily: "Product-Bold",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.5))),
                                )
                              ]),
                              Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      alignment: Alignment.bottomRight,
                                      child: Text(snapshot.data['totaldebit']
                                          .toString())),
                                )
                              ]),
                              Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      alignment: Alignment.bottomRight,
                                      child: Text(snapshot.data['totalkredit']
                                          .toString())),
                                )
                              ]),
                              // Column(children: [
                              //   Text(snapshot.data['totalkredit'].toString())
                              // ]),
                            ])
                          ],
                        ),
                      ],
                    ),
                  );

                  // for(int i in b){
                  // print(i);
                  //   // return Text((snapshot.data['data']['January'][1]['perkiraan']).toString());

                  // }
                } else {
                  return Text(" ");
                }
                return Center(child: CircularProgressIndicator());
              },
            )
          ],
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
  //                 // FilterAwal(),
  //                 Padding(
  //                   padding: const EdgeInsets.only(
  //                       right: 150, top: 20.0, bottom: 20.0),
  //                   child: Text(
  //                     "sampai dengan",
  //                     style: TextStyle(color: Colors.black54),
  //                   ),
  //                 ),
  //                 // FilterAwal()
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
