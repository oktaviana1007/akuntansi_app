import 'package:akuntansi_app/API.dart';
import 'package:akuntansi_app/DataTransaksi.dart';
import 'package:akuntansi_app/model/data.dart';
import 'package:http/http.dart' as http;
import 'package:akuntansi_app/EditDataTransaksi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailTransaksi extends StatefulWidget {
  // final jenisTransaksiModel model;
  // final VoidCallback reload;
  // DetailTransaksi(this.model, this.reload);
  // List list;
  // int index;
  // DetailTransaksi({this.index, this.list});
  final Datas list;

  DetailTransaksi(this.list);
  @override
  _DetailTransaksiState createState() => _DetailTransaksiState();
}

enum MenuOption { Ubah, Hapus }

class _DetailTransaksiState extends State<DetailTransaksi> {
  // final _key = new GlobalKey<FormState>();

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Are You sure want to delete '${widget.list.keterangan}'"),
      actions: <Widget>[
        new RaisedButton(
            child: new Text(
              "Ya",
              style: new TextStyle(color: Colors.black),
            ),
            color: Colors.red,
            onPressed: () {
              // deleteData();
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new DataTransaksi(),
              ));
            }),
        new RaisedButton(
          child: new Text(
            "Tidak",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(context: context, child: alertDialog);
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return Dialog(
    //         child: ListView(
    //           padding: EdgeInsets.all(16.0),
    //           shrinkWrap: true,
    //           children: <Widget>[
    //             Text(
    //               "Anda yakin ingin menghapus data ini?",
    //               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    //             ),
    //             SizedBox(
    //               height: 10.0,
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: <Widget>[
    //                 InkWell(
    //                     onTap: () {
    //                       Navigator.pop(context);
    //                     },
    //                     child: Text("Tidak")),
    //                 SizedBox(
    //                   width: 16.0,
    //                 ),
    //                 InkWell(
    //                     onTap: () {
    //                       deleteData();
    //                       Navigator.of(context).push(new MaterialPageRoute(
    //                         builder: (BuildContext context) =>
    //                             new DataTransaksi(),
    //                       ));
    //                     },
    //                     child: Text("Ya")),
    //               ],
    //             )
    //           ],
    //         ),
    //       );
    //     });
  }

  // void deleteData() {
  //   http.post(BaseUrl.APIdeleteDataTransaksi,
  //       body: {'id': widget.list.keterangan}
  //   final data = jsonDecode(response.body);
  //   int value = data['value'];
  //   if (value == 1) {
  //     setState(() {
  //       Navigator.pop(context);
  //       _lihatData();
  //       tampilToast("Berhasil dihapus");
  //     });
  //   } else {
  //     tampilToast("Gagal dihapus");
  //   }
  // }

  TextEditingController txtjenisTransaksi,
      txtpilihan1,
      txtpilihan2,
      txtketerangan;
  setup() async {
    txtjenisTransaksi =
        TextEditingController(text: widget.list.keterangan);
    txtpilihan1 =
        TextEditingController(text: widget.list.perkiraan1);
    txtpilihan2 =
        TextEditingController(text: widget.list.perkiraan2);
    txtketerangan =
        TextEditingController(text: widget.list.keterangan);
  }

  // var _autovalidate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Transaksi'),
        actions: <Widget>[
          PopupMenuButton(itemBuilder: (context) {
            List<PopupMenuEntry<Object>> menus = new List();
            menus.add(PopupMenuItem(
                value: 1,
                child: ListTile(
                  title: Text("Edit"),
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => EditDataTransaksi(widget.list)));
                  },
                )));

            menus.add(PopupMenuItem(
                value: 1,
                child: ListTile(
                  title: Text("Hapus"),
                  onTap: () => confirm(),
                )));
            return menus;
          })
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: ScreenUtil.getInstance().setHeight(460),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, -10.0),
                            blurRadius: 10.0),
                      ]),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 17.0, top: 13),
                          child: TextField(
                            controller: txtjenisTransaksi,
                            style: TextStyle(fontSize: 25),
                            enabled: false,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12, top: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, top: 18),
                                  child: Text(
                                    "Nominal",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 60.0),
                                child: Text(
                                  "Rp.",
                                  style: TextStyle(fontSize: 35),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  widget.list.jumlah
                                      .toString(),
                                  style: TextStyle(fontSize: 35),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 18,
                          thickness: 0.5,
                          color: Colors.black.withOpacity(0.3),
                          indent: 0,
                          endIndent: 0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5.0, left: 22),
                                // child:
                                //     Text(),
                                child: TextField(
                                  controller: txtpilihan2,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: "Diterima dari"),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                ),
                                // child:
                                //     Text(widget.list[widget.index]['pilihan1']),
                                child: TextField(
                                  controller: txtpilihan1,
                                  enabled: false,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: "Disimpan ke"),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.note,
                          color: Colors.blue,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Info Transaksi",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: ScreenUtil.getInstance().setHeight(300),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 15.0),
                            blurRadius: 15.0),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 25, top: 8),
                        // child: Text(widget.list[widget.index]['keterangan']),
                        child: TextField(
                          controller: txtketerangan,
                          enabled: false,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Keterangan"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, top: 20),
                        child: Text(
                          "Tanggal Transaksi",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 26, top: 3),
                        child: Text(
                          widget.list.tanggal.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
