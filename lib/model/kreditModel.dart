class Kredit {
  List<Data3> data;
  bool success;

  Kredit({this.data, this.success});

  Kredit.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data3>();
      json['data'].forEach((v) {
        data.add(new Data3.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data3 {
  int id;
  String namaPerkiraan;

  Data3({this.id, this.namaPerkiraan});

  Data3.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaPerkiraan = json['nama_perkiraan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_perkiraan'] = this.namaPerkiraan;
    return data;
  }
}
