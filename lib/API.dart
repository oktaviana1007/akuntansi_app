
import 'package:akuntansi_app/model/jenisTransaksi.dart';
import 'package:akuntansi_app/model/kreditModel.dart';
import 'package:akuntansi_app/model/perkiraan.dart';
import 'package:dio/dio.dart';

class BaseUrl {
  static String login = "http://34.87.189.146:8000/api/login";
  static String register = "http://34.87.189.146:8000/api/register";
  static String dataTransaksi = "http://34.87.189.146:8000/api/jurnal/lihatjurnal";
  static String tambahDataTransaksi = "http://34.87.189.146:8000/api/jurnal/create";
  static String hapusDataTransaksi = "http://34.87.189.146:8000/api/jurnal/hapus";
  static String editDataTransaksi = "http://34.87.189.146:8000/api/jurnal/edit";
  // static String APIeditDataTransaksi = "http://beranekaragam.com/akuntansi/EditDataTransaksi.php";
  // static String APIdeleteDataTransaksi = "http://beranekaragam.com/akuntansi/DeleteDataTransaksi.php?id=";

}