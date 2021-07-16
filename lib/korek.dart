import 'dart:convert';
import 'package:akuntansi_app/model/perkiraan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'DetailRekening.dart';

class Korek extends StatefulWidget {
  @override
  _KorekState createState() => _KorekState();
}

class _KorekState extends State<Korek> {
  String token, rekening, perkiraan;
  int ide;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      ide = preferences.getInt("id");
      print("data : $ide");
    });
    getData();
  }

  // List list;
  // Future getData() async {
  //   String apiURL = "http://34.87.189.146:8000/api/rekening";
  //   var data = await http.get(apiURL, headers: {
  // 'Accept': 'application/json',
  // 'Authorization': 'Bearer $token'
  //   });
  //   var jsonData = json.decode(data.body);
  //   print(jsonData);
  //   print(token);
  //   setState(() {
  //     list = jsonData['data'];
  //   });
  //   // print(jsonData.statusCode);
  //   // return jsonData;
  // }
  List<Perkiraan> _kira = [];

  Future<Null> getData() async {
    // List<Data> list;
    String link = "http://34.87.189.146:8000/api/perkiraan/";
    final res = await http.get(Uri.encodeFull(link), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    print(res.body);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      setState(() {
        for (Map i in data) {
          _kira.add(Perkiraan.fromJson(i));
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: _kira.length,
          itemBuilder: (context, i) {
            final x = _kira[i];
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: new Text(
                      x.rekening,
                      style: TextStyle(fontSize: 17),
                    ),
                    onTap: () => Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailRekening(x))),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
