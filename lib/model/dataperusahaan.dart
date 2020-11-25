class Dataperusahaan {
  Data data;

  Dataperusahaan({this.data});

//   factory Dataperusahaan.fromJson(Map<String, dynamic> json)=> Dataperusahaan(
//    data: List<Dataperusahaan>.from(json["data"].map((x) => Dataperusahaan.fromJson(x))),
//  );

  Dataperusahaan.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String name;
  String email;
  String namaPerusahaan;
  String alamatPerusahaan;
  String teleponPerusahaan;
  String emailPerusahaan;
  String joined;

  Data(
      {this.id,
      this.name,
      this.email,
      this.namaPerusahaan,
      this.alamatPerusahaan,
      this.teleponPerusahaan,
      this.emailPerusahaan,
      this.joined});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    namaPerusahaan = json['nama_perusahaan'];
    alamatPerusahaan = json['alamat_perusahaan'];
    teleponPerusahaan = json['telepon_perusahaan'];
    emailPerusahaan = json['email_perusahaan'];
    joined = json['joined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['nama_perusahaan'] = this.namaPerusahaan;
    data['alamat_perusahaan'] = this.alamatPerusahaan;
    data['telepon_perusahaan'] = this.teleponPerusahaan;
    data['email_perusahaan'] = this.emailPerusahaan;
    data['joined'] = this.joined;
    return data;
  }
}
