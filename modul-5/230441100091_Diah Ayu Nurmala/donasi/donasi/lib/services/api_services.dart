import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/donasi_model.dart';

class DonasiService {
  final String baseUrl = 'http://localhost/donasi/';

  Future<List<Donasi>> fetchDonasi() async {
    final response = await http.get(Uri.parse('${baseUrl}read_donasi.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Donasi>.from(data.map((json) => Donasi.fromJson(json)));
    } else {
      throw Exception('Gagal mengambil data donasi');
    }
  }

  Future<bool> addDonasi(Donasi donasi) async {
    final response = await http.post(
      Uri.parse('${baseUrl}create_donasi.php'),
      body: donasi.toJson(),
    );
    return response.statusCode == 200;
  }

  Future<bool> updateDonasi(Donasi donasi) async {
    final response = await http.post(
      Uri.parse('${baseUrl}update_donasi.php'),
      body: {'id': donasi.id.toString(), ...donasi.toJson()},
    );
    return response.statusCode == 200;
  }

  Future<bool> deleteDonasi(int id) async {
    final response = await http.post(
      Uri.parse('${baseUrl}delete_donasi.php'),
      body: {'id': id.toString()},
    );
    return response.statusCode == 200;
  }
}
