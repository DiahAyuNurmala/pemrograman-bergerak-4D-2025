class Donasi {
  String? id; // hanya ID dokumen, bukan path lengkap
  String nama;
  int nominal;
  String tujuan;
  DateTime tanggal;

  Donasi({
    required this.id,
    required this.nama,
    required this.nominal,
    required this.tujuan,
    required this.tanggal,
  });

  factory Donasi.fromJson(Map<String, dynamic> json) {
    final fields = json['fields'];
    return Donasi(
      id: json['name'].split('/').last, // Ambil hanya ID dokumen
      nama: fields['nama']['stringValue'],
      nominal: int.parse(fields['nominal']['integerValue']),
      tujuan: fields['tujuan']['stringValue'],
      tanggal: DateTime.parse(fields['tanggal']['timestampValue']),
    );
  }
}
