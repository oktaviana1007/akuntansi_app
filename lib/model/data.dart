class Datas {
  final String tanggal;
  final int jumlah;
  final String keterangan;
  final String perkiraan1;
  final String perkiraan2;
  final int id_transaksi;
  final int perkiraan1_id;
  final int perkiraan2_id;
  final int jenis_transaksi_id;
  final String jenis_transaksi;

  Datas(this.tanggal, this.keterangan, this.jumlah, this.perkiraan1, this.perkiraan2, this.id_transaksi, this.jenis_transaksi, this.jenis_transaksi_id, this.perkiraan1_id, this.perkiraan2_id);

  // factory Datas.formJson(Map <String, dynamic> json){
  //   return new Datas(
  //      tanggal: json['tanggal'],
  //      keterangan: json['keterangan'],
  //      jumlah: json['jumlah'],
  //      perkiraan1: json['perkiraan1'],
  //      perkiraan2: json['perkiraan2'],
  //   );
  // }
}