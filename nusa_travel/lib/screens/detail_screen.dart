import 'package:flutter/material.dart';

import '../models/tour_package.dart';
import 'booking_screen.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({required this.package, super.key});

  final TourPackage package;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Wisata')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(
              package.imageUrl,
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                height: 260,
                color: colors.primaryContainer,
                child: Icon(
                  Icons.landscape_rounded,
                  size: 72,
                  color: colors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            package.title,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            package.description,
            style: TextStyle(
              color: colors.onSurfaceVariant,
              fontSize: 16,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colors.primaryContainer.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Icon(Icons.sell_outlined, color: colors.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Harga mulai dari'),
                      const SizedBox(height: 4),
                      Text(
                        '${package.formattedPrice} / orang',
                        style: TextStyle(
                          color: colors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: 54,
            child: FilledButton.icon(
              onPressed: () async {
                final booking = await Navigator.push<BookingResult>(
                  context,
                  MaterialPageRoute<BookingResult>(
                    builder: (_) => BookingScreen(package: package),
                  ),
                );

                if (booking != null && context.mounted) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          'Pemesanan ${package.title} berhasil '
                          'untuk ${booking.participantCount} peserta.',
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                }
              },
              icon: const Icon(Icons.calendar_month_rounded),
              label: const Text('Pesan Sekarang'),
            ),
          ),
        ],
      ),
    );
  }
}
