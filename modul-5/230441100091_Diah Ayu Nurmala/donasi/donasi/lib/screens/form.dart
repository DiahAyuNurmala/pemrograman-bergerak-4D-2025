import 'package:flutter/material.dart';
import '../models/donasi_model.dart';

class FormDonasiScreen extends StatefulWidget {
  final Donasi? donasi;
  final Function(Donasi) onSubmit;

  const FormDonasiScreen({super.key, this.donasi, required this.onSubmit});

  @override
  State<FormDonasiScreen> createState() => _FormDonasiScreenState();
}

class _FormDonasiScreenState extends State<FormDonasiScreen> {
  late TextEditingController namaController;
  late TextEditingController nominalController;
  late TextEditingController tanggalController;
  late TextEditingController tujuanController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.donasi?.nama ?? '');
    nominalController = TextEditingController(
      text: widget.donasi?.nominal.toString() ?? '',
    );
    tanggalController = TextEditingController(
      text: widget.donasi?.tanggal ?? '',
    );
    tujuanController = TextEditingController(text: widget.donasi?.tujuan ?? '');
  }

  void submit() {
    final newDonasi = Donasi(
      id: widget.donasi?.id ?? 0,
      nama: namaController.text,
      nominal: int.tryParse(nominalController.text) ?? 0,
      tanggal: tanggalController.text,
      tujuan: tujuanController.text,
    );
    widget.onSubmit(newDonasi);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.donasi == null ? 'Tambah Donasi' : 'Edit Donasi'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: nominalController,
              decoration: const InputDecoration(labelText: 'Nominal'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: tanggalController,
              decoration: const InputDecoration(
                labelText: 'Tanggal (YYYY-MM-DD HH:MM:SS)',
              ),
            ),
            TextField(
              controller: tujuanController,
              decoration: const InputDecoration(labelText: 'Tujuan'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(onPressed: submit, child: const Text('Simpan')),
      ],
    );
  }
}
