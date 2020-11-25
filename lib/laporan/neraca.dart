// import 'package:akuntansi2/modal/filter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class Neraca extends StatefulWidget {
  @override
  NeracaState createState() => NeracaState();
}

class NeracaState extends State<Neraca> {
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

   List listMonth= [
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

  List listYear=[
    "2018",
    "2019",
    "2020"
  ];

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
Future getData(String month, String year) async{
  // final prefs = await SharedPreferences.getInstance();
  //   final key = 'api_token';
  //   final value = prefs.get(key) ?? 0;
  //   print(value);
  String apiURL = "http://34.87.189.146:8000/api/report/neraca/view";
  var data= await http.post(apiURL,
  headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  },
    body: {
            "month": "$month",
            "year": "$year"
          }
  );

  var jsonData=json.decode(data.body);
  print(jsonData);
  print(data.statusCode);
  return jsonData;
}

  @override
  void initState(){
    super.initState;
    setup();
    getData(month,year);
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Neraca"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child:Container(
        padding: EdgeInsets.only(left: 5, right: 5),
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
                          top: 12.0, right: 30.0, left: 10, bottom: 20),
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
            Table(
              border: TableBorder(
                verticalInside: BorderSide(color: Colors.black, width: 1),
                horizontalInside: BorderSide(color: Colors.transparent)
              ),
              children: [
                TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                children: [
                  Text(""),
                  Text(month, style: TextStyle(fontWeight: FontWeight.w500, fontFamily: "Product-Bold",),
                         textAlign: TextAlign.center),
                ]),
              ]
            ),
            FutureBuilder(
              future: getData(month,year),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                 if (snapshot.connectionState != ConnectionState.done)
                    return Center(child: CircularProgressIndicator());
                  if (!snapshot.hasData || snapshot.data == null)
                    return Container();
                  if (snapshot.data.isEmpty)
                    return Container();
                if(snapshot.hasData){
                  a=snapshot.data[month];
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Table(
                          border: TableBorder(
                          verticalInside: BorderSide(color: Colors.black, width: 1),
                          horizontalInside: BorderSide(color: Colors.transparent)
                        ),
                        children:[
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 180,
                                  child: Text("AKTIVA", style: TextStyle(fontFamily: 'Product-Bold', 
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text("")
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 180,
                                  child: Text(a[0]['rekening'], style: TextStyle(fontFamily: 'Product-Bold', 
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text("")
                              ],
                            )
                          ]
                          ),
                          
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(a[0]['perkiraan'][0]['nama_perkiraan'], style: TextStyle(fontSize: 12),)
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((a[0]['perkiraan'][0]['jumlah']).toString(),
                                      textAlign: TextAlign.start, style: TextStyle(fontSize: 12)),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.end)
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(a[0]['perkiraan'][1]['nama_perkiraan'], style: TextStyle(fontSize: 12),)
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((a[0]['perkiraan'][1]['jumlah']).toString(),textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 12)),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.end)
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(a[0]['perkiraan'][2]['nama_perkiraan'], style: TextStyle(fontSize: 12),)
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((a[0]['perkiraan'][2]['jumlah']).toString(),textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 12)),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.end)
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(a[0]['perkiraan'][3]['nama_perkiraan'], style: TextStyle(fontSize: 12),)
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((a[0]['perkiraan'][3]['jumlah']).toString(),textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 12)),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.end)
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(a[0]['perkiraan'][4]['nama_perkiraan'], style: TextStyle(fontSize: 12),)
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((a[0]['perkiraan'][4]['jumlah']).toString(),textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 12)),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.end)
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(a[0]['perkiraan'][5]['nama_perkiraan'], style: TextStyle(fontSize: 12),)
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((a[0]['perkiraan'][5]['jumlah']).toString(),textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 12)),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.end)
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(a[0]['perkiraan'][6]['nama_perkiraan'], style: TextStyle(fontSize: 12),)
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((a[0]['perkiraan'][6]['jumlah']).toString(),textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 12)),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.end)
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 180,
                                  child: Text((a[0]['text']), style: TextStyle(fontFamily: 'Product-Bold', 
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.start),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((a[0]['total']).toString(),textAlign: TextAlign.end, style: TextStyle(fontSize: 12))
                                    ),
                                    
                                  ]
                                )
                              ],
                            ),
                          ]
                          ),
                          TableRow(
                          children:[
                            Column(
                              children: [
                            Text("")
                              ],
                            ),
                            Column(
                              children: [
                                Text("")
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 180,
                                  child: Text((a[1]['rekening']), style: TextStyle(fontFamily: 'Product-Bold', fontWeight: FontWeight.bold,
                                  fontSize: 12))
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text("")
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(a[1]['perkiraan'][0]['nama_perkiraan'], style: TextStyle(fontSize: 12),)
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((a[1]['perkiraan'][0]['jumlah']).toString(),textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 12)),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.end)
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(a[1]['perkiraan'][1]['nama_perkiraan'], style: TextStyle(fontSize: 12),)
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((a[1]['perkiraan'][1]['jumlah']).toString(),textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 12)),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.end)
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(a[1]['perkiraan'][2]['nama_perkiraan'], style: TextStyle(fontSize: 12),)
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((a[1]['perkiraan'][2]['jumlah']).toString(),textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 12)),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.end)
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(a[1]['perkiraan'][3]['nama_perkiraan'], style: TextStyle(fontSize: 12),)
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((a[1]['perkiraan'][3]['jumlah']).toString(),textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 12)),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.end)
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 180,
                                  child: Text((a[1]['text']), style: TextStyle(fontFamily: 'Product-Bold', fontWeight: FontWeight.bold,
                                  fontSize: 12))
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.start),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((a[1]['total']).toString(),textAlign: TextAlign.end, style: TextStyle(fontSize: 12))
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 180,
                                  child: Text((snapshot.data['text_a']), style: TextStyle(fontFamily: 'Product-Bold', fontWeight: FontWeight.bold,
                                  fontSize: 12))
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.start),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((snapshot.data['total_aktiva']).toString(),textAlign: TextAlign.end, style: TextStyle(fontSize: 12))
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ),
                          TableRow(
                          children:[
                            Column(
                              children: [
                            Text("")
                              ],
                            ),
                            Column(
                              children: [
                                Text("")
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 180,
                                  child: Text("UTANG DAN MODAL", style: TextStyle(fontFamily: 'Product-Bold', fontWeight: FontWeight.bold,
                                  fontSize: 12))
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text("")
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 180,
                                  child: Text((a[2]['rekening']), style: TextStyle(fontFamily: 'Product-Bold', fontWeight: FontWeight.bold,
                                  fontSize: 12))
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text("")
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(a[2]['perkiraan'][0]['nama_perkiraan'], style: TextStyle(fontSize: 12),)
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((a[2]['perkiraan'][0]['jumlah']).toString(),textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 12)),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.end)
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 180,
                                  child: Text((a[1]['text']), style: TextStyle(fontFamily: 'Product-Bold', fontWeight: FontWeight.bold,
                                  fontSize: 12))
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.start),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((a[2]['total']).toString(),textAlign: TextAlign.end, style: TextStyle(fontSize: 12))
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ),
                          TableRow(
                          children:[
                            Column(
                              children: [
                            Text("")
                              ],
                            ),
                            Column(
                              children: [
                                Text("")
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 180,
                                  child: Text((a[3]['rekening']), style: TextStyle(fontFamily: 'Product-Bold', 
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12))
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text("")
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(a[3]['perkiraan'][0]['nama_perkiraan'], style: TextStyle(fontSize: 12),)
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((a[3]['perkiraan'][0]['jumlah']).toString(),textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 12)),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.end)
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ),                          
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 180,
                                  child: Text((a[3]['text']), style: TextStyle(fontFamily: 'Product-Bold', fontWeight: FontWeight.bold,
                                  fontSize: 12))
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.start),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text((a[3]['total']).toString(), style: TextStyle(fontSize: 12)),
                                        ],
                                      )
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ),
                          TableRow(
                          children:[
                            Column(
                              children: [
                            Text("")
                              ],
                            ),
                            Column(
                              children: [
                                Text("")
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 180,
                                  child: Text((a[4]['rekening']), style: TextStyle(fontFamily: 'Product-Bold', fontWeight: FontWeight.bold,
                                  fontSize: 12))
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text("")
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(a[4]['perkiraan'][0]['nama_perkiraan'], style: TextStyle(fontSize: 12),)
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((a[4]['perkiraan'][0]['jumlah']).toString(),textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 12)),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.end)
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ), 
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(a[4]['perkiraan'][1]['nama_perkiraan'], style: TextStyle(fontSize: 12),)
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((a[4]['perkiraan'][1]['jumlah']).toString(),textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 12)),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.end)
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ), 
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: Text(a[4]['perkiraan'][2]['nama_perkiraan'], style: TextStyle(fontSize: 12),)
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((a[4]['perkiraan'][2]['jumlah']).toString(),textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 12)),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.end)
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ), 
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 180,
                                  child: Text((a[4]['text']), style: TextStyle(fontFamily: 'Product-Bold', fontWeight: FontWeight.bold,
                                  fontSize: 12))
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.start),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((a[4]['total']).toString(),textAlign: TextAlign.end, style: TextStyle(fontSize: 12))
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ),
                          TableRow(decoration: BoxDecoration(color: Colors.grey[200]),
                          children:[
                            Column(
                              children: [
                                Container(
                                  width: 180,
                                  child: Text((snapshot.data['text_b']), style: TextStyle(fontFamily: 'Product-Bold', fontWeight: FontWeight.bold,
                                  fontSize: 12))
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text("",textAlign: TextAlign.start),
                                    ),
                                    Container(
                                      width: 80,
                                      child: Text((snapshot.data['total_utang_modal']).toString(),textAlign: TextAlign.end, style: TextStyle(fontSize: 12))
                                    ),
                                    
                                  ]
                                )
                              ],
                            )
                          ]
                          ),                         
                        ]
                        )
                      ],
                    )
                  );
                }
                else{
                  return Center(child:CircularProgressIndicator());
                }
              }
            )
            
          ],
        ),
      ),
      )
      
    );
  }
}
