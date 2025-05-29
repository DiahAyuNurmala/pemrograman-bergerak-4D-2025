import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/donasi_model.dart';

class DonasiService {
  final String baseUrl =
      'https://firestore.googleapis.com/v1/projects/donasiapp-5614c/databases/(default)/documents/catatan_donasi';

  // Ambil data donasi
  Future<List<Donasi>> getDonasiList() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['documents'] != null) {
        return (jsonData['documents'] as List)
            .map((doc) => Donasi.fromJson(doc))
            .toList();
      }
      return [];
    } else {
      throw Exception('Gagal mengambil data');
    }
  }

  // Tambah data donasi
  Future<void> addDonasi(Donasi donasi) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'fields': {
          'nama': {'stringValue': donasi.nama},
          'nominal': {'integerValue': donasi.nominal.toString()},
          'tujuan': {'stringValue': donasi.tujuan},
          'tanggal': {'timestampValue': donasi.tanggal.toIso8601String() + 'Z'},
        },
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Gagal menambah data: ${response.body}');
    }
  }

  // Update data donasi
  Future<void> updateDonasi(Donasi donasi) async {
    final url = '$baseUrl/${donasi.id}';
    final response = await http.patch(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'fields': {
          'nama': {'stringValue': donasi.nama},
          'nominal': {'integerValue': donasi.nominal.toString()},
          'tujuan': {'stringValue': donasi.tujuan},
          'tanggal': {'timestampValue': donasi.tanggal.toIso8601String() + 'Z'},
        },
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal memperbarui data: ${response.body}');
    }
  }

  // Hapus data donasi berdasarkan ID
  Future<void> deleteDonasi(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id')); // ✅
    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus data: ${response.body}');
    }
  }
}
