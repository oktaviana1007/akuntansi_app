import 'package:akuntansi_app/MainDrawer.dart';
import 'package:akuntansi_app/Pengaturan.dart';
import 'package:akuntansi_app/TambahDataTransaksi.dart';
import 'package:akuntansi_app/transaksiLangsung.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Transaksi extends StatefulWidget {
  @override
  _TransaksiState createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  var _month = [
    'Januari',
    'Febuari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'July',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];
  var _year = ['2018', '2019', '2020'];
  var _currentItemSelected = 'Januari';
  var _currentItemSelected2 = '2018';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Transaksi',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        drawer: MainDrawer(),
        body: Container(
          child: Column(
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
                          child: DropdownButton<String>(
                            isDense: true,
                            items: _month.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                this._currentItemSelected = newValueSelected;
                              });
                            },
                            value: _currentItemSelected,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, right: 40.0),
                      child: Container(
                        padding: EdgeInsets.only(right: 12.0, left: 12.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38, width: 1.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isDense: true,
                            hint: Text('Pilih Bulan'),
                            items: _year.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                this._currentItemSelected2 = newValueSelected;
                              });
                            },
                            value: _currentItemSelected2,
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
                  height: 50,
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
              Container(
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
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 50.0, top: 8.0),
                      child: Text(
                        "Penjualan produk",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 320.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                        child: Text(
                          '8',
                          style: TextStyle(fontSize: 23, color: Colors.white),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, left: 270.0),
                      child: Text("RP.   0,00",
                          style:
                              TextStyle(color: Colors.black, fontSize: 18.0)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
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
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 50.0, top: 8.0),
                        child: Text(
                          "Pembayaran gaji karyawan",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 320.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 7.0),
                          child: Text(
                            '15',
                            style: TextStyle(fontSize: 23, color: Colors.white),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0, left: 270.0),
                        child: Text("RP.   0,00",
                            style:
                                TextStyle(color: Colors.black, fontSize: 18.0)),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
                      builder: (context) => TambahDataTransaksi(),
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
                    builder: (context) => Pengaturan(),
                  ),
                );
              },
            ),
          ],
        ));
  }
}
