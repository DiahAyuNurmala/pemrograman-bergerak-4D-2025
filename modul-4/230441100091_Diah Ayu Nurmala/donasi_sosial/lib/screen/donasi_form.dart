import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/donasi_model.dart';
import '../services/donasi_service.dart';

class FormScreen extends StatefulWidget {
  final Donasi? donasi; // null = tambah, ada isi = edit
  const FormScreen({Key? key, this.donasi}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nominalController = TextEditingController();
  final _tujuanController = TextEditingController();
  final _tanggalController = TextEditingController();
  final DonasiService _service = DonasiService();

  @override
  void initState() {
    super.initState();
    if (widget.donasi != null) {
      _namaController.text = widget.donasi!.nama;
      _nominalController.text = widget.donasi!.nominal.toString();
      _tujuanController.text = widget.donasi!.tujuan;
      _tanggalController.text = DateFormat(
        'yyyy-MM-dd',
      ).format(widget.donasi!.tanggal);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    if (_tanggalController.text.isNotEmpty) {
      selectedDate = DateFormat('yyyy-MM-dd').parse(_tanggalController.text);
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _tanggalController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final donasi = Donasi(
        id: widget.donasi?.id, // null saat tambah, isi saat edit
        nama: _namaController.text,
        nominal: int.parse(_nominalController.text),
        tujuan: _tujuanController.text,
        tanggal: DateFormat('yyyy-MM-dd').parse(_tanggalController.text),
      );

      try {
        if (widget.donasi == null) {
          await _service.addDonasi(donasi);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data berhasil ditambahkan')),
          );
        } else {
          await _service.updateDonasi(donasi);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data berhasil diperbarui')),
          );
        }
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Gagal menyimpan data')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.donasi == null ? 'Tambah Donasi' : 'Edit Donasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator:
                    (value) => value!.isEmpty ? 'Nama harus diisi' : null,
              ),
              TextFormField(
                controller: _nominalController,
                decoration: const InputDecoration(labelText: 'Nominal'),
                keyboardType: TextInputType.number,
                validator:
                    (value) => value!.isEmpty ? 'Nominal harus diisi' : null,
              ),
              TextFormField(
                controller: _tujuanController,
                decoration: const InputDecoration(labelText: 'Tujuan'),
                validator:
                    (value) => value!.isEmpty ? 'Tujuan harus diisi' : null,
              ),
              TextFormField(
                controller: _tanggalController,
                decoration: const InputDecoration(labelText: 'Tanggal'),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator:
                    (value) => value!.isEmpty ? 'Tanggal harus dipilih' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.donasi == null ? 'Tambah' : 'Perbarui'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
