import 'package:flutter/material.dart';

import '../models/registration_ticket.dart';

class RegisteredTicketsScreen extends StatelessWidget {
  const RegisteredTicketsScreen({
    required this.tickets,
    required this.onCancel,
    super.key,
  });

  final List<RegistrationTicket> tickets;
  final ValueChanged<RegistrationTicket> onCancel;

  Future<bool> _confirmCancellation(
    BuildContext context,
    RegistrationTicket ticket,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.deepOrange),
        title: const Text('Batalkan tiket?'),
        content: Text(
          'Tiket untuk "${ticket.event.title}" akan dihapus dari daftar aktif.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Kembali'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade700),
            child: const Text('Ya, batalkan'),
          ),
        ],
      ),
    );
    return confirmed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    if (tickets.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 82,
                height: 82,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F3F0),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.confirmation_number_outlined,
                  color: Color(0xFF147D78),
                  size: 38,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Belum ada tiket',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF152B4A),
                ),
              ),
              const SizedBox(height: 7),
              Text(
                'Tiket seminar yang kamu daftarkan akan muncul di sini.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueGrey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        final ticket = tickets[index];
        return Dismissible(
          key: ValueKey(ticket.id),
          direction: DismissDirection.endToStart,
          confirmDismiss: (_) => _confirmCancellation(context, ticket),
          onDismissed: (_) => onCancel(ticket),
          background: Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.only(right: 22),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: const Color(0xFFFFE6E3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete_outline, color: Colors.red, size: 26),
                SizedBox(height: 4),
                Text(
                  'Batalkan',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          child: _TicketCard(ticket: ticket),
        );
      },
    );
  }
}

class _TicketCard extends StatelessWidget {
  const _TicketCard({required this.ticket});

  final RegistrationTicket ticket;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ticket.event.color, const Color(0xFF152B4A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white.withValues(alpha: 0.18),
                  child: Icon(ticket.event.icon, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TIKET AKTIF',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          letterSpacing: 1.3,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        ticket.event.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(17),
            child: Column(
              children: [
                _TicketInfoRow(
                  label: 'Peserta',
                  value: '${ticket.name} · ${ticket.participantType}',
                ),
                _TicketInfoRow(label: 'NIM', value: ticket.nim),
                _TicketInfoRow(label: 'Tanggal hadir', value: _formatDate(ticket.attendanceDate)),
                _TicketInfoRow(
                  label: 'Seminar kit',
                  value: ticket.seminarKit ? 'Termasuk' : 'Tidak termasuk',
                ),
                _TicketInfoRow(
                  label: 'Donasi',
                  value: ticket.donation == 0 ? '—' : 'Rp ${_formatPrice(ticket.donation)}',
                  isLast: true,
                ),
                const Divider(height: 22),
                Row(
                  children: [
                    const Icon(Icons.qr_code_2, size: 34, color: Color(0xFF152B4A)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'ID ${ticket.id.substring(ticket.id.length - 8)}',
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.swipe_left_alt_outlined,
                      color: Colors.blueGrey,
                      size: 18,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TicketInfoRow extends StatelessWidget {
  const _TicketInfoRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 112,
            child: Text(
              label,
              style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 12),
            ),
          ),
          const Text('·  ', style: TextStyle(color: Color(0xFF147D78))),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF152B4A),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _formatDate(DateTime date) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];
  return '${date.day} ${months[date.month - 1]} ${date.year}';
}

String _formatPrice(int amount) =>
    amount.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) {
      return '${match[1]}.';
    });
