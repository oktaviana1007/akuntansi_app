import 'dart:convert';

import 'package:akuntansi_app/Norek.dart';
import 'package:akuntansi_app/model/perkiraan.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailRekening extends StatefulWidget {
  final Widget child;
  // final String nama_perkiraan;
  final Perkiraan perki;

  DetailRekening(this.perki, {Key key, this.child}) : super(key: key);

  @override
  _DetailRekeningState createState() => _DetailRekeningState();
}

class _DetailRekeningState extends State<DetailRekening> {
  String token;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token");
      print(token);
    });
  }

//  String url = "http://34.87.189.146:8000/api/perkiraan";
  final url = "http://34.87.189.146:8000/api/perkiraan";

  Future<String> deleteWithBodyExample() async {
    // final baseUrl = "http://34.87.189.146:8000/api/perkiraan";
    final urrl = Uri.parse(url);
    final request = http.Request("DELETE", urrl);
    request.headers.addAll(<String, String>{
      "Accept": "application/json",
      "token": "my token",
      "jwt": "my jwt"
    });
    request.body = jsonEncode({"id": 4});
    final response = await request.send();
    if (response.statusCode != 200)
      return Future.error("error: status code ${response.statusCode}");
    return await response.stream.bytesToString();
  }

//  void deleteData() async {
//      var response = await http.delete(url, headers: {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token'
//     }, body: {
//       'id': widget.perki.data[i].id
//     }
//         );
//         final data = jsonDecode(response.body);
//         bool value = data['success'];
//         String message = data['message'];
//         if (value == true ) {
//           setState(() {
//             print(data);
//             // print(token);
//             // Navigator.pop(context);
//             // _lihatData();
//             tampilToast(message);
//           });
//         } else {
//             // print(token);
//           print("Gagal dihapus");
//         }
//   }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.perki.rekening),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: ListView.builder(
            itemCount: widget.perki.data.length,
            itemBuilder: (context, i) {
              final x = widget.perki.data[i];

              TextEditingController txtjenisTransaksi;
              txtjenisTransaksi =
                  new TextEditingController(text: x.namaPerkiraan);

              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, left: 2.0, right: 2.0),
                      child: TextField(
                        controller: txtjenisTransaksi,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(3),
                              child: GestureDetector(
                                child: Icon(Icons.close),
                                onTap: () async {
                                  final urrl = Uri.parse(url);
                                  final request = http.Request("DELETE", urrl);
                                  request.headers.addAll(<String, String>{
                                    "Accept": "application/json",
                                    'Authorization': 'Bearer $token'
                                  });
                                  request.body = jsonEncode({"id": x.id});
                                  final response = await request.send();
                                  if (response.statusCode != 200)
                                    return Future.error(
                                        "error: status code ${response.statusCode}");
                                  return await response.stream.bytesToString();
                                },
                              ),
                            )),
                      ),
                    ),
                    //   ListTile(
                    //     title: new Text(
                    //       x.namaPerkiraan,
                    //       style: TextStyle(fontSize: 17),
                    //     )
                    //  ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
