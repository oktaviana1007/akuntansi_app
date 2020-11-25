import 'package:intl/intl.dart';

class Rekening {
 bool success;
 List<Data> data;

 Rekening({this.success, this.data});

 factory Rekening.fromJson(Map<String, dynamic> json)=> Rekening(
   success: json["success"],
   data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
 );

 Map<String, dynamic> toJson()=>{
   "success":success,
   "data": List<dynamic>.from(data.map((x) => x.toJson())),
 };
}

class Data{
  int id;
  String nama_rekening;
  String tipe;
  
  Data({this.id, this.nama_rekening, this.tipe, });

  factory Data.fromJson(Map<String, dynamic> json) {
     Data(
        id: json["id"],
        nama_rekening: json["nama_rekening"],
        tipe: json["tipe"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_rekening": nama_rekening,
        "tipe": tipe,
  };
}