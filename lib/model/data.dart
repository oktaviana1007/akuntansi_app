class Datas {
  final String tanggal;
  final int jumlah;
  final String keterangan;
  final String perkiraan1;
  final String perkiraan2;

  Datas(this.tanggal, this.keterangan, this.jumlah, this.perkiraan1, this.perkiraan2);

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