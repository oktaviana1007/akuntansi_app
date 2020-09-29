class JenisTransaksi {
  List<Data> data;
  bool success;

  JenisTransaksi({this.data, this.success});

  JenisTransaksi.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  int id;
  String jenis;
  String keterangan1;
  String keterangan2;

  Data({this.id, this.jenis, this.keterangan1, this.keterangan2});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jenis = json['jenis'];
    keterangan1 = json['keterangan1'];
    keterangan2 = json['keterangan2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jenis'] = this.jenis;
    data['keterangan1'] = this.keterangan1;
    data['keterangan2'] = this.keterangan2;
    return data;
  }
}
