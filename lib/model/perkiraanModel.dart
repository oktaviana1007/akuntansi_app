class Perkiraan {
  List<Data2> data;
  bool success;

  Perkiraan({this.data, this.success});

  Perkiraan.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data2>();
      json['data'].forEach((v) {
        data.add(new Data2.fromJson(v));
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

class Data2 {
  int id;
  String namaPerkiraan;

  Data2({this.id, this.namaPerkiraan});

  Data2.fromJson(Map<String, dynamic> json) {
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
