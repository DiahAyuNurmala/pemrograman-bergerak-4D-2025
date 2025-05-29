import 'package:flutter/material.dart';
import '../models/donasi_model.dart';
import '../services/api_services.dart';
import 'form.dart';

class HomeDonasiScreen extends StatefulWidget {
  const HomeDonasiScreen({super.key});

  @override
  State<HomeDonasiScreen> createState() => _HomeDonasiScreenState();
}

class _HomeDonasiScreenState extends State<HomeDonasiScreen> {
  final DonasiService api = DonasiService();
  late Future<List<Donasi>> _data;

  @override
  void initState() {
    super.initState();
    _data = api.fetchDonasi();
  }

  void refresh() {
    setState(() {
      _data = api.fetchDonasi();
    });
  }

  void showForm({Donasi? donasi}) {
    showDialog(
      context: context,
      builder:
          (_) => FormDonasiScreen(
            donasi: donasi,
            onSubmit: (d) async {
              bool success =
                  donasi == null
                      ? await api.addDonasi(d)
                      : await api.updateDonasi(d);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(success ? 'Berhasil' : 'Gagal')),
              );
              if (success) refresh();
            },
          ),
    );
  }

  void deleteData(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Hapus'),
            content: const Text('Yakin ingin menghapus data ini?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Hapus'),
              ),
            ],
          ),
    );
    if (confirm == true) {
      bool success = await api.deleteDonasi(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(success ? 'Dihapus' : 'Gagal hapus')),
      );
      if (success) refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Donasi')),
      body: FutureBuilder<List<Donasi>>(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final list = snapshot.data!;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final d = list[index];
                return ListTile(
                  title: Text('${d.nama} - Rp${d.nominal}'),
                  subtitle: Text('${d.tujuan} | ${d.tanggal}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () => showForm(donasi: d),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteData(d.id),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Terjadi kesalahan'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
