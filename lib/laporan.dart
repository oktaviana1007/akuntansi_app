import 'package:akuntansi_app/laporan/bukuBesar.dart';
import 'package:akuntansi_app/laporan/jurnal.dart';
import 'package:akuntansi_app/laporan/labaRugi.dart';
import 'package:akuntansi_app/laporan/neraca.dart';
import 'package:akuntansi_app/laporan/neracaSaldo.dart';
import 'package:akuntansi_app/mainDrawer.dart';
import 'package:flutter/material.dart';

class Laporan extends StatefulWidget {
  @override
  _LaporanState createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Laporan',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: Container(
        //color:Colors.blue,
        child: ListView(
          children: <Widget>[
            CustomListTile(
                  'Jurnal',
                  'Laporan Rekapitulasi Jurnal',
                  () {Navigator.push(
                      context,
                      MaterialPageRoute (builder: (context) => Jurnal()),
                    );
                  }
            ),
            CustomListTile(
                  "Buku Besar",
                  'Laporan Bentuk Buku Besar',
                  () {Navigator.push(
                      context,
                      MaterialPageRoute (builder: (context) => BukuBesar()),
                    );
                  }
            ),
            CustomListTile(
                  "Neraca Saldo",
                  'Laporan Bentuk Neraca Saldo',
                  () {Navigator.push(
                      context,
                      MaterialPageRoute (builder: (context) => NeracaSaldo()),
                    );
                  }
            ),
            CustomListTile(
                  "Laba Rugi",
                  'Laporan Bentuk Laba Rugi',
                  () {Navigator.push(
                      context,
                      MaterialPageRoute (builder: (context) => LabaRugi()),
                    );
                  }
            ),
            CustomListTile(
                  "Neraca",
                  'Laporan Bentuk Neraca',
                  () {Navigator.push(
                      context,
                      MaterialPageRoute (builder: (context) => Neraca()),
                    );
                  }
            ),
            // CustomListTile(
            //       "Periode",
            //       'Melihat Laporan Berdasarkan Periode',
            //       () {Navigator.push(
            //           context,
            //           MaterialPageRoute (builder: (context) => Jurnal()),
            //         );
            //       }
            // ),
            //  CustomListTile(
            //       "Utang",
            //       'Laporan Data Utang',
            //       () {Navigator.push(
            //           context,
            //           MaterialPageRoute (builder: (context) => Jurnal()),
            //         );
            //       }
            // ),
            //  CustomListTile(
            //       "Piutang",
            //       'Laporan Data Piutang',
            //       () {Navigator.push(
            //           context,
            //           MaterialPageRoute (builder: (context) => Jurnal()),
            //         );
            //       }
            // ),
          ],
        ),
      ),
    );
  }
}



class CustomListTile extends StatelessWidget{

  String sub;
  String text;
  Function onTap;

  CustomListTile (this.sub,this.text,this.onTap);


  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left : 20.0, right: 10.0, top: 10.0),
      child: Container(
        
        child: InkWell(
          splashColor: Colors.black,
          onTap: onTap,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1.0),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(13),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(sub, style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black
                      ),),
                      Text(text, style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black
                        ),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
