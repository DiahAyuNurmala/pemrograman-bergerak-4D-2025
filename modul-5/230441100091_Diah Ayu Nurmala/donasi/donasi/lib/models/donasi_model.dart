class Donasi {
  final int id;
  final String nama;
  final int nominal;
  final String tanggal;
  final String tujuan;

  Donasi({
    required this.id,
    required this.nama,
    required this.nominal,
    required this.tanggal,
    required this.tujuan,
  });

  factory Donasi.fromJson(Map<String, dynamic> json) {
    return Donasi(
      id: int.parse(json['id']),
      nama: json['nama'],
      nominal: int.parse(json['nominal']),
      tanggal: json['tanggal'],
      tujuan: json['tujuan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'nominal': nominal.toString(),
      'tanggal': tanggal,
      'tujuan': tujuan,
    };
  }
}
