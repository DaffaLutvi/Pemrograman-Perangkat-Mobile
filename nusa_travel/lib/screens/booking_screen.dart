import 'package:flutter/material.dart';

import '../models/tour_package.dart';

class BookingResult {
  const BookingResult({
    required this.name,
    required this.participantCount,
    required this.departureDate,
  });

  final String name;
  final int participantCount;
  final DateTime departureDate;
}

class BookingScreen extends StatefulWidget {
  const BookingScreen({required this.package, super.key});

  final TourPackage package;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _participantController = TextEditingController(text: '1');

  DateTime? _departureDate;
  bool _isConfirmingBack = false;

  @override
  void dispose() {
    _nameController.dispose();
    _participantController.dispose();
    super.dispose();
  }

  Future<void> _selectDepartureDate() async {
    final today = DateUtils.dateOnly(DateTime.now());
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _departureDate ?? today,
      firstDate: today,
      lastDate: DateTime(today.year + 2),
      helpText: 'Pilih tanggal keberangkatan',
      cancelText: 'Batal',
      confirmText: 'Pilih',
    );

    if (selectedDate != null && mounted) {
      setState(() => _departureDate = selectedDate);
    }
  }

  Future<void> _confirmBackNavigation() async {
    if (_isConfirmingBack) return;
    _isConfirmingBack = true;

    final shouldLeave = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Batalkan pemesanan?'),
        content: const Text(
          'Data pemesanan yang sudah diisi tidak akan disimpan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Lanjutkan isi'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Batalkan'),
          ),
        ],
      ),
    );

    _isConfirmingBack = false;
    if (shouldLeave == true && mounted) {
      Navigator.pop(context);
    }
  }

  void _submitBooking() {
    if (!_formKey.currentState!.validate()) return;
    if (_departureDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih tanggal keberangkatan.')),
      );
      return;
    }

    Navigator.pop(
      context,
      BookingResult(
        name: _nameController.text.trim(),
        participantCount: int.parse(_participantController.text.trim()),
        departureDate: _departureDate!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final dateText = _departureDate == null
        ? 'Pilih tanggal keberangkatan'
        : '${_departureDate!.day.toString().padLeft(2, '0')}/'
              '${_departureDate!.month.toString().padLeft(2, '0')}/'
              '${_departureDate!.year}';

    return PopScope<BookingResult>(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmBackNavigation();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Form Pemesanan')),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                widget.package.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${widget.package.formattedPrice} / orang',
                style: TextStyle(
                  color: colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 28),
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nama pemesan',
                  hintText: 'Masukkan nama lengkap',
                  prefixIcon: Icon(Icons.person_outline_rounded),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama pemesan wajib diisi.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: _participantController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah peserta',
                  hintText: 'Contoh: 2',
                  prefixIcon: Icon(Icons.groups_rounded),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final count = int.tryParse(value?.trim() ?? '');
                  if (count == null || count < 1) {
                    return 'Masukkan jumlah peserta minimal 1.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),
              OutlinedButton.icon(
                onPressed: _selectDepartureDate,
                icon: const Icon(Icons.event_outlined),
                label: Text(dateText),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(54),
                  alignment: Alignment.centerLeft,
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                height: 54,
                child: FilledButton(
                  onPressed: _submitBooking,
                  child: const Text(
                    'Konfirmasi Pemesanan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
