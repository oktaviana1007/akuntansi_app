import 'package:akuntansi_app/DataTransaksi.dart';
import 'package:akuntansi_app/Pengaturan.dart';
import 'package:akuntansi_app/laporan.dart';
import 'package:akuntansi_app/kalkulator.dart';
import 'package:akuntansi_app/perusahaan.dart';
import 'package:akuntansi_app/profil.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

// enum LoginStatus { notSignIn, signIn, signInAdmin }
class _MainDrawerState extends State<MainDrawer> {
// LoginStatus _loginStatus = LoginStatus.notSignIn;
// signOut() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     setState(() {
//       preferences.setInt("value", null);
//       preferences.setString("level", null);
//       preferences.commit();
//       _loginStatus = LoginStatus.notSignIn;
//     });
//   }
  String namaPerusahaan;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      namaPerusahaan = preferences.getString("nama_perusahaan");
    });
    print("nama: $namaPerusahaan");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Colors.blue,
      child: ListView(children: <Widget>[
        DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Container(
                child: new Column(children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profil()),
                  );
                },
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 70,
                      width: 70,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                                "https://png.pngtree.com/png-clipart/20190614/original/pngtree-vector-shop-icon-png-image_3788233.jpg"),
                      ),
                    )
                        // Image.asset('images/logo.png', width: 70, height: 70),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    '$namaPerusahaan'.toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                ),
              ),
            ]))),
        Divider(
          height: 5,
          thickness: 0.5,
          color: Colors.black.withOpacity(0.3),
          indent: 0,
          endIndent: 0,
        ),
        // CustomListTile(Icons.dashboard, 'Dashboard', () {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => Dashboard()),
        //   );
        // }),
        CustomListTile(FontAwesomeIcons.handHoldingUsd, 'Transaksi', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DataTransaksi()),
          );
        }),
        Divider(
          height: 10,
          thickness: 0.5,
          color: Colors.black.withOpacity(0.3),
          indent: 0,
          endIndent: 0,
        ),
        CustomListTile(FontAwesomeIcons.fileInvoiceDollar, 'Laporan', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Laporan()),
          );
        }),
        Divider(
          height: 10,
          thickness: 0.5,
          color: Colors.black.withOpacity(0.3),
          indent: 0,
          endIndent: 0,
        ),
        CustomListTile(
          Icons.settings,
          'Pengaturan',
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Pengaturan()),
            );
          },
        ),
        Divider(
          height: 10,
          thickness: 0.5,
          color: Colors.black.withOpacity(0.3),
          indent: 0,
          endIndent: 0,
        ),
        CustomListTile(FontAwesomeIcons.calculator, 'Kalkulator', () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SimpleCalculator()),
          );
        }),
      ]),
    ));
  }
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        child: InkWell(
          splashColor: Colors.black,
          onTap: onTap,
          child: Container(
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 0.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          text,
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        )),
                  ],
                ),

                //  Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
