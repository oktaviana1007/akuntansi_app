import 'dart:convert';

import 'package:akuntansi_app/API.dart';
import 'package:akuntansi_app/model/rekeningModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Norek extends StatefulWidget {
  @override
  _NorekState createState() => _NorekState();
}

class _NorekState extends State<Norek> {
  String token, rekening, perkiraan;
  int ide;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      ide = preferences.getInt("id");
      print("data : $ide");
    });
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

  Future getData() async {
    // List<Data> list;
    String link = "http://34.87.189.146:8000/api/rekening/";
    var res = await http.get(Uri.encodeFull(link), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    // print(res.body);
    // if (res.statusCode == 200) {
    //   var data = json.decode(res.body);
    //   var rest = data["data"] as List;
    //   print(rest);
    //   list = rest.map<Data>((json) => Data.fromJson(json)).toList();
    // }
    var jsonData = json.decode(res.body);
    print(jsonData);
    print(res.statusCode);
    return jsonData;
    // print("List Size: ${list.length}");
    // return data;
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
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(
            'No Rekening',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done)
              return Center(child: CircularProgressIndicator());
            if (!snapshot.hasData || snapshot.data == null)
              return Container();
            if (snapshot.data.isEmpty) return Container();
            if (snapshot.hasData){
                final c = snapshot.data['data'];
              if (c == null) {
                  return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                    ),
                );
              }else {
              return ListView.builder(
                itemCount: c.length == null ? 0 : c.length,
                itemBuilder: (context, i) {
                  // final c = snapshot.data['data'];
                  return new Container(
                    padding: const EdgeInsets.all(5.0),
                    child: new GestureDetector(
                      // onTap: () => Navigator.push(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (context) => DetailTransaksi(c[i]))),
                      child: new Card(
                        elevation: 2.0,
                        child: Container(
                          width: double.infinity,
                          height: 75,
                          decoration: BoxDecoration(
                              color: Colors.white,
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
                              ListTile(
                                title: new Text(
                                  c[i]['nama_rekening'],
                                  style: TextStyle(fontSize: 17),
                                ),
                                // trailing: Padding(
                                //   padding: const EdgeInsets.only(top: 35.0),
                                //   child: new Text(
                                //     c[i].jumlah.toString(),
                                //     style: TextStyle(fontSize: 20),
                                //   ),
                                // ),
                                // subtitle: new Text(
                                //   c[i].tanggal.toString(),
                                //   style: TextStyle(fontSize: 12),
                                // ),
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
            }
          },
        ));
  }
}
