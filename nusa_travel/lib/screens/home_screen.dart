import 'package:flutter/material.dart';

import '../models/tour_package.dart';
import '../routes/app_routes.dart';

const _tourPackages = [
  TourPackage(
    id: 'bali-ubud',
    title: 'Pesona Ubud, Bali',
    description:
        'Jelajahi sawah terasering, hutan tropis, dan suasana seni yang menenangkan di Ubud.',
    price: 1850000,
    imageUrl:
        'https://images.unsplash.com/photo-1537996194471-e657df975ab4?auto=format&fit=crop&w=1200&q=85',
  ),
  TourPackage(
    id: 'raja-ampat',
    title: 'Surga Raja Ampat',
    description:
        'Nikmati pulau karst, pantai jernih, dan keindahan bawah laut Papua Barat.',
    price: 4250000,
    imageUrl:
        'https://images.unsplash.com/photo-1510414842594-a61c69b5ae57?auto=format&fit=crop&w=1200&q=85',
  ),
  TourPackage(
    id: 'bromo',
    title: 'Matahari Terbit Bromo',
    description:
        'Saksikan matahari terbit dari kawasan pegunungan dan lautan pasir Bromo.',
    price: 1350000,
    imageUrl:
        'https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=1200&q=85',
  ),
  TourPackage(
    id: 'labuan-bajo',
    title: 'Petualangan Labuan Bajo',
    description:
        'Berlayar ke pulau-pulau eksotis dan temui pesona alam Nusa Tenggara Timur.',
    price: 3150000,
    imageUrl:
        'https://images.unsplash.com/photo-1544551763-46a013bb70d5?auto=format&fit=crop&w=1200&q=85',
  ),
  TourPackage(
    id: 'yogyakarta',
    title: 'Jejak Budaya Yogyakarta',
    description:
        'Kenali warisan budaya, candi bersejarah, dan kuliner khas Yogyakarta.',
    price: 990000,
    imageUrl:
        'https://images.unsplash.com/photo-1596402184320-417e7178b2cd?auto=format&fit=crop&w=1200&q=85',
  ),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NusaTravel',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.splash,
                (_) => false,
              );
            },
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Logout'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Waktunya berpetualang',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Pilih destinasi favoritmu dan mulai perjalanan tak terlupakan.',
                  style: TextStyle(color: Colors.white70, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Paket wisata pilihan',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          ..._tourPackages.map(
            (package) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _TourPackageCard(
                package: package,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.detail,
                    arguments: package,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TourPackageCard extends StatelessWidget {
  const _TourPackageCard({required this.package, required this.onTap});

  final TourPackage package;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              package.imageUrl,
              height: 175,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                height: 175,
                color: colors.primaryContainer,
                child: Icon(
                  Icons.landscape_rounded,
                  size: 56,
                  color: colors.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          package.title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${package.formattedPrice} / orang',
                          style: TextStyle(
                            color: colors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(Icons.arrow_forward_rounded, color: colors.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
