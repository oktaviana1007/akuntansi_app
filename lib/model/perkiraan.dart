class Perkiraan {
  String rekening;
  List<Data> data;

  Perkiraan({this.rekening, this.data});

  Perkiraan.fromJson(Map<String, dynamic> json) {
    rekening = json['rekening'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rekening'] = this.rekening;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String namaPerkiraan;
  int rekeningId;
  String createdAt;
  String updatedAt;
  Null deletedAt;

  Data(
      {this.id,
      this.namaPerkiraan,
      this.rekeningId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaPerkiraan = json['nama_perkiraan'];
    rekeningId = json['rekening_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_perkiraan'] = this.namaPerkiraan;
    data['rekening_id'] = this.rekeningId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
