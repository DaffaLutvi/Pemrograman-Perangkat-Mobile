import 'package:flutter/material.dart';

import '../models/event_item.dart';
import '../models/registration_ticket.dart';

class EventRegistrationScreen extends StatefulWidget {
  const EventRegistrationScreen({required this.event, super.key});

  final EventItem event;

  @override
  State<EventRegistrationScreen> createState() =>
      _EventRegistrationScreenState();
}

class _EventRegistrationScreenState extends State<EventRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nimController = TextEditingController();
  final _emailController = TextEditingController();
  final _whatsAppController = TextEditingController();

  String _participantType = 'Mahasiswa';
  DateTime? _attendanceDate;
  bool _seminarKit = true;
  bool _agreedToRules = false;
  int _donation = 0;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _nimController.dispose();
    _emailController.dispose();
    _whatsAppController.dispose();
    super.dispose();
  }

  Future<void> _pickAttendanceDate() async {
    final today = DateUtils.dateOnly(DateTime.now());
    final initial = _attendanceDate ?? widget.event.date;
    final date = await showDatePicker(
      context: context,
      initialDate: initial.isBefore(today) ? today : initial,
      firstDate: today,
      lastDate: today.add(const Duration(days: 365)),
      helpText: 'Pilih tanggal kehadiran',
      cancelText: 'Batal',
      confirmText: 'Pilih',
    );
    if (date != null) setState(() => _attendanceDate = date);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_attendanceDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih tanggal kehadiran terlebih dahulu.')),
      );
      return;
    }
    if (!_agreedToRules) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Setujui tata tertib untuk melanjutkan.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    await Future<void>.delayed(const Duration(milliseconds: 850));
    if (!mounted) return;

    final ticket = RegistrationTicket(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      event: widget.event,
      name: _nameController.text.trim(),
      nim: _nimController.text.trim(),
      email: _emailController.text.trim(),
      whatsApp: _whatsAppController.text.trim(),
      participantType: _participantType,
      attendanceDate: _attendanceDate!,
      seminarKit: _seminarKit,
      donation: _donation,
      registeredAt: DateTime.now(),
    );
    Navigator.of(context).pop(ticket);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pendaftaran seminar')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
              children: [
                _EventSummary(event: widget.event),
                const SizedBox(height: 20),
                const _SectionTitle(
                  title: 'Data peserta',
                  subtitle: 'Isi data dengan benar untuk menerima tiket.',
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Nama lengkap',
                    prefixIcon: Icon(Icons.person_outline),
                    hintText: 'Nama sesuai identitas',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().length < 3) {
                      return 'Nama minimal terdiri dari 3 karakter.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _nimController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'NIM',
                    prefixIcon: Icon(Icons.badge_outlined),
                    hintText: 'Masukkan nomor induk mahasiswa',
                  ),
                  validator: (value) {
                    final nim = value?.trim() ?? '';
                    if (!RegExp(r'^\d{6,20}$').hasMatch(nim)) {
                      return 'NIM harus terdiri dari 6–20 angka.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.mail_outline),
                    hintText: 'nama@email.com',
                  ),
                  validator: (value) {
                    final email = value?.trim() ?? '';
                    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                        .hasMatch(email)) {
                      return 'Masukkan alamat email yang valid.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _whatsAppController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Nomor WhatsApp',
                    prefixIcon: Icon(Icons.phone_android),
                    hintText: 'Contoh: 081234567890',
                  ),
                  validator: (value) {
                    final number =
                        (value ?? '').replaceAll(RegExp(r'[\s+()-]'), '');
                    if (!RegExp(r'^\d{10,15}$').hasMatch(number)) {
                      return 'Nomor WhatsApp harus terdiri dari 10–15 angka.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const _SectionTitle(
                  title: 'Preferensi kehadiran',
                  subtitle: 'Atur kebutuhanmu selama acara.',
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  initialValue: _participantType,
                  decoration: const InputDecoration(
                    labelText: 'Tipe peserta',
                    prefixIcon: Icon(Icons.groups_outlined),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Mahasiswa',
                      child: Text('Mahasiswa'),
                    ),
                    DropdownMenuItem(
                      value: 'Dosen',
                      child: Text('Dosen'),
                    ),
                    DropdownMenuItem(
                      value: 'Umum',
                      child: Text('Umum'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _participantType = value);
                  },
                ),
                const SizedBox(height: 12),
                InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: _pickAttendanceDate,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Tanggal kehadiran',
                      prefixIcon: Icon(Icons.calendar_month_outlined),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    child: Text(
                      _attendanceDate == null
                          ? 'Pilih tanggal'
                          : _formatDate(_attendanceDate!),
                      style: TextStyle(
                        color: _attendanceDate == null
                            ? Colors.blueGrey.shade400
                            : const Color(0xFF152B4A),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: CheckboxListTile(
                    value: _seminarKit,
                    onChanged: (value) =>
                        setState(() => _seminarKit = value ?? false),
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text(
                      'Paket seminar kit',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: const Text(
                      'Buku catatan, pulpen, dan merchandise acara',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  initialValue: _donation,
                  decoration: const InputDecoration(
                    labelText: 'Donasi opsional',
                    prefixIcon: Icon(Icons.volunteer_activism_outlined),
                  ),
                  items: const [
                    DropdownMenuItem(value: 0, child: Text('Tidak berdonasi')),
                    DropdownMenuItem(value: 10000, child: Text('Rp 10.000')),
                    DropdownMenuItem(value: 25000, child: Text('Rp 25.000')),
                    DropdownMenuItem(value: 50000, child: Text('Rp 50.000')),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _donation = value);
                  },
                ),
                const SizedBox(height: 12),
                Card(
                  child: CheckboxListTile(
                    value: _agreedToRules,
                    onChanged: (value) =>
                        setState(() => _agreedToRules = value ?? false),
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text(
                      'Saya menyetujui tata tertib acara',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: const Text(
                      'Tiket berlaku untuk satu peserta dan tidak dapat dipindahtangankan.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _isSubmitting ? null : _submit,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(54),
                    backgroundColor: const Color(0xFF147D78),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Daftar sekarang',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EventSummary extends StatelessWidget {
  const _EventSummary({required this.event});

  final EventItem event;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: CircleAvatar(
          backgroundColor: event.color.withValues(alpha: 0.12),
          child: Icon(event.icon, color: event.color),
        ),
        title: Text(
          event.title,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text('${event.category}  •  ${_formatDate(event.date)}'),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF152B4A),
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 12),
        ),
      ],
    );
  }
}

String _formatDate(DateTime date) {
  const months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];
  return '${date.day} ${months[date.month - 1]} ${date.year}';
}
