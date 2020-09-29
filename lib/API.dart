

import 'package:akuntansi_app/model/jenisTransaksi.dart';
import 'package:akuntansi_app/model/kreditModel.dart';
import 'package:akuntansi_app/model/perkiraanModel.dart';
import 'package:dio/dio.dart';

class BaseUrl {
  static String login = "http://34.87.189.146:8000/api/login";
  static String register = "http://34.87.189.146:8000/api/register";
  static String APIdataTransaksi = "http://34.87.189.146:8000/api/jurnal/lihatjurnal";
  static String APItambahDataTransaksi = "http://34.87.189.146:8000/api/jurnal/create";
  static String APIeditDataTransaksi = "http://beranekaragam.com/akuntansi/EditDataTransaksi.php";
  static String APIdeleteDataTransaksi = "http://beranekaragam.com/akuntansi/DeleteDataTransaksi.php?id=";

}

class DatabaseHelper{
  Dio dio = Dio();
  String serverUrl = "http://34.87.189.146:8000/api";
  
  Future<JenisTransaksi> getJenisAsync() async {
   // final prefs = await SharedPreferences.getInstance();
    final key = 'GEkOo6sFgqDia4EfVarRMu73Vh6d5qwMfl5XtXn6sD3OiuKEXIZ7wIQ2C1tKFQUBpGDBIDGtsiLCedHN';
   // final value = prefs.get(key) ?? 0;
    Response response;
    try {
      response = await dio.get(serverUrl + "/jenistransaksi",
          options: Options(headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $key'
    }));

      if (response.statusCode == 200) {
        final jenisModel = JenisTransaksi.fromJson(response.data);

        // print(jenisModel.data.first.toJson());
        return jenisModel;
      } else
        return null;
    } on DioError catch (e) {
      return null;
    }
  }

  Future<Perkiraan> getPerkiraanAsync(int ids) async {
   // final prefs = await SharedPreferences.getInstance();
    final key = 'GEkOo6sFgqDia4EfVarRMu73Vh6d5qwMfl5XtXn6sD3OiuKEXIZ7wIQ2C1tKFQUBpGDBIDGtsiLCedHN';
   // final value = prefs.get(key) ?? 0;
  //  int id = 1;
    Response response;
    try {
      response = await dio.get(serverUrl + "/mapping/debit/$ids",
          options: Options(headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $key',
    }));

      if (response.statusCode == 200) {
        final perkiraanModel = Perkiraan.fromJson(response.data);
        // print(perkiraanModel.data.first.toJson());
        return perkiraanModel;
      } else
        return null;
    } on DioError catch (e) {
      return null;
    }
  }

   Future<Kredit> getPerkiraan2Async(int id) async {
   // final prefs = await SharedPreferences.getInstance();
    final key = 'GEkOo6sFgqDia4EfVarRMu73Vh6d5qwMfl5XtXn6sD3OiuKEXIZ7wIQ2C1tKFQUBpGDBIDGtsiLCedHN';
   // final value = prefs.get(key) ?? 0;
  //  int id = 1;
    Response response;
    try {
      response = await dio.get(serverUrl + "/mapping/kredit/$id",
          options: Options(headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $key',
    }));

      if (response.statusCode == 200) {
        final kreditModel = Kredit.fromJson(response.data);
        // print(perkiraanModel.data.first.toJson());
        return kreditModel;
      } else
        return null;
    } on DioError catch (e) {
      return null;
    }
  }
}

