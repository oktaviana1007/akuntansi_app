import 'dart:convert';

// import 'package:akuntansi2/modal/filter.dart';
// import 'package:akuntansi2/modal/filterPerkiraan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BukuBesar extends StatefulWidget {
  @override
  _BukuBesarState createState() => _BukuBesarState();
}

class _BukuBesarState extends State<BukuBesar> {
  String month;
  String year;
  String kira;
  setup() async {
    month = "September";
    year = "2020";
    kira = "Kas";
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

  List listPerkiraan = [
    "Kas",
    "Bank",
    "Perlengkapan",
    "Persediaan Bahan Baku",
    "Persediaan Bahan Dagang",
    "Piutang Usaha",
    "Sewa Dibayar Dimuka",
    "Tanah",
    "Bangunan",
    "Kendaraan",
    "Peralatan",
    "Akumulasi Penyusutan Kendaraan",
    "Akumulasi Penyusutan Peralatan",
    "Akumulasi Penyusutan Bangunan",
    "Utang Usaha",
    "Utang Bank",
    "Modal Pemilik",
    "Prive",
    "Pendapatan",
    "Penjualan Barang",
    "Ikhtisar Laba/Rugi",
    "Potongan Penjualan",
    "Retur Penjualan",
    "Harga Pokok Penjualan",
    "Potongan Pembelian",
    "Retur Pembelian",
    "Biaya Pengiriman",
    "Biaya Penjualan Lain-lain",
    "Biaya Air",
    "Biaya Depresiasi Peralatan",
    "Biaya Gaji Karyawan",
    "Biaya Listrik",
    "Biaya Makan dan Minum",
    "Biaya Perlengkapan",
    "Biaya Tempat Sewa Usaha",
    "Biaya Telepon",
    "Biaya Umum Lain-lain",
  ];

  String token;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      print("data : $token");
    });
  }

  Future getData(String month, String year, String kira) async {
    String apiURL = "http://34.87.189.146:8000/api/report/bukubesar/view";
    var data = await http.post(apiURL, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      "month": "$month",
      "year": "$year",
      "nama_perkiraan": "$kira"
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
    getData(month, year, kira);
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Buku Besar"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, left: 30),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        right: 20.0, left: 20.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black38, width: 1.0),
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
                                      top: 12.0,
                                      right: 30.0,
                                      left: 10,
                                      bottom: 20),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        right: 20.0, left: 20.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black38, width: 1.0),
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
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, bottom: 20),
                              child: Container(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 20.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black38, width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: Text("Jenis Transaksi"),
                                    value: kira,
                                    items: listPerkiraan.map((value) {
                                      return DropdownMenuItem(
                                        child: Text(value),
                                        value: value,
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        kira = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Table(
                      border: TableBorder(
                          horizontalInside: BorderSide(
                              width: 0.5,
                              color: Colors.black,
                              style: BorderStyle.solid)),
                      columnWidths: {
                        0: FixedColumnWidth(75),
                        1: FixedColumnWidth(120),
                        2: FixedColumnWidth(70),
                        3: FixedColumnWidth(70),
                        4: FixedColumnWidth(80)
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
                              Column(children: [
                                Container(
                                  padding: EdgeInsets.all(7),
                                ),
                                Text("Saldo",
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
                      future: getData(month, year, kira),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          var a = snapshot.data['data'][month];
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
                                          horizontalInside: BorderSide(
                                              width: 0.5,
                                              color: Colors.black,
                                              style: BorderStyle.solid)),
                                      columnWidths: {
                                        0: FixedColumnWidth(75),
                                        1: FixedColumnWidth(120),
                                        2: FixedColumnWidth(60),
                                        3: FixedColumnWidth(80),
                                        4: FixedColumnWidth(50)
                                      },
                                      children: [
                                        TableRow(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200]),
                                            children: [
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text((a[index]['tanggal']),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Product-Bold",
                                                              fontSize: 10.5,
                                                              letterSpacing:
                                                                  0.5)),
                                                    ),
                                                  ]),
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                          (a[index]
                                                              ['keterangan']),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Product-Bold",
                                                              fontSize: 12,
                                                              letterSpacing:
                                                                  0.5)),
                                                    ),
                                                  ]),
                                              Column(children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    alignment: Alignment.bottomRight,
                                                    child: Text(
                                                        (a[index]['jenis'])
                                                                    .toString() ==
                                                                "D"
                                                            ? (a[index]['jumlah'])
                                                                .toString()
                                                            : "0",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Product-Bold",
                                                            fontSize: 12,
                                                            letterSpacing: 0.5)),
                                                  ),
                                                )
                                              ]),
                                              Column(children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 20.0, top: 8, bottom: 8),
                                                  child: Container(
                                                    alignment: Alignment.bottomRight,
                                                    child: Text(
                                                        (a[index]['jenis'])
                                                                    .toString() ==
                                                                "D"
                                                            ? "0"
                                                            : (a[index]['jumlah'])
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Product-Bold",
                                                            fontSize: 12,
                                                            letterSpacing: 0.5)),
                                                  ),
                                                )
                                              ]),
                                              Column(children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      (a[index]['total'])
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Product-Bold",
                                                          fontSize: 12,
                                                          letterSpacing: 0.5)),
                                                )
                                              ]),
                                            ]),
                                      ],
                                    );
                                  }),
                                  Divider(
              height: 2,
              thickness: 1,
              color: Colors.black,
              indent: 0,
              endIndent: 0,
            ),
                              Table(
                                border: TableBorder(
                                    horizontalInside: BorderSide(
                                        width: 0.5,
                                        color: Colors.black,
                                        style: BorderStyle.solid)),
                                columnWidths: {
                                  0: FixedColumnWidth(75),
                                  1: FixedColumnWidth(120),
                                  2: FixedColumnWidth(60),
                                  3: FixedColumnWidth(80),
                                  4: FixedColumnWidth(50)
                                },
                                children: [
                                  TableRow(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200]),
                                      children: [
                                        Column(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              // alignment: Alignment.topLeft,
                                              child: Text("Total",
                                                  
                                    style: TextStyle(
                                        fontFamily: "Product-Bold",
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5)),
                                            ),
                                          ),
                                        ]),
                                        Column(children: [
                                          Column(
                                            children: [Text("")],
                                          )
                                        ]),
                                        Column(children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  alignment: Alignment.bottomRight,
                                                  child: Text(
                                                      snapshot.data['totaldebit']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Product-Bold",
                                                          fontSize: 12,
                                                          letterSpacing: 0.3)),
                                                ),
                                              )
                                            ],
                                          )
                                        ]),
                                        Column(children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0, bottom: 8, right: 20),
                                                child: Container(
                                                  alignment: Alignment.bottomRight,
                                                  child: Text(
                                                      snapshot.data['totalkredit']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Product-Bold",
                                                          fontSize: 12,
                                                          letterSpacing: 0.3)),
                                                ),
                                              )
                                            ],
                                          )
                                        ]),
                                        Column(children: [
                                          Column(
                                            children: [
                                              Text(
                                                  snapshot.data['totalsaldo']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "Product-Bold",
                                                      fontSize: 10,
                                                      letterSpacing: 0.3))
                                            ],
                                          )
                                        ]),
                                      ])
                                ],
                              ),
                            ],
                          ));
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
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
  //                 FilterPerkiraan(),
  //                 FilterAwal(),
  //                 Padding(
  //                   padding: const EdgeInsets.only(
  //                       right: 150, top: 20.0, bottom: 20.0),
  //                   child: Text(
  //                     "sampai dengan",
  //                     style: TextStyle(color: Colors.black54),
  //                   ),
  //                 ),
  //                 FilterAwal(),
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
