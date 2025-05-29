import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/donasi_service.dart';
import '../models/donasi_model.dart';
import 'donasi_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DonasiService _service = DonasiService();
  List<Donasi> _data = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Fungsi untuk memuat data
  void _loadData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<Donasi> data = await _service.getDonasiList();
      setState(() {
        _data = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal memuat data')));
    }
  }

  // Fungsi untuk menghapus data
  void _deleteData(String id) async {
    try {
      await _service.deleteDonasi(id);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Data berhasil dihapus')));
      _loadData(); // Refresh setelah hapus
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menghapus data')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Donasi')),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _data.isEmpty
              ? const Center(child: Text('Belum ada data'))
              : ListView.builder(
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  var donasi = _data[index];
                  return ListTile(
                    title: Text(donasi.nama),
                    subtitle: Text(
                      'Rp ${donasi.nominal} • ${donasi.tujuan} • ${DateFormat('dd/MM/yyyy').format(donasi.tanggal)}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit), // Ikon Edit
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FormScreen(donasi: donasi),
                              ),
                            );
                            _loadData(); // Refresh setelah edit
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteData(donasi.id!),
                        ),
                      ],
                    ),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FormScreen(donasi: donasi),
                        ),
                      );
                      _loadData(); // refresh setelah edit
                    },
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormScreen()),
          );
          _loadData(); // refresh setelah tambah
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
