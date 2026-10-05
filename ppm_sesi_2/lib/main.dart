import 'package:flutter/material.dart';

// Ganti dengan data diri masing-masing.
const String nama = 'Daffa Lutvi Mahendra';
const String nim = '20240040142';
const String prodiKelas = 'Teknik Informatika / TI24G';

const Color _navy = Color(0xFF142B4A);
const Color _blue = Color(0xFF2864C5);
const Color _pageBackground = Color(0xFFF4F7FB);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PPM Sesi 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _pageBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _blue,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: _navy,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: Text(
          'PPM Sesi 2 - $nama ($nim)',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Selamat datang,',
                    style: Theme.of(context).textTheme.bodyLarge
                        ?.copyWith(color: const Color(0xFF718096)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    nama,
                    style: Theme.of(context).textTheme.headlineSmall
                        ?.copyWith(color: _navy, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 14),
                  const PromoBanner(),
                  const SizedBox(height: 14),
                  const _SectionHeading(
                    title: 'Profil mahasiswa',
                    subtitle: 'Informasi akademik Anda',
                  ),
                  const SizedBox(height: 8),
                  const ProfileCard(
                    nama: nama,
                    nim: nim,
                    prodiKelas: prodiKelas,
                  ),
                  const SizedBox(height: 14),
                  const _SectionHeading(
                    title: 'Produk pilihan',
                    subtitle: 'Atur jumlah dan tambahkan ke keranjang',
                  ),
                  const SizedBox(height: 8),
                  const ProductCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title, required this.subtitle});

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
            color: _navy,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: const TextStyle(color: Color(0xFF718096), fontSize: 13),
        ),
      ],
    );
  }
}

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 132),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_navy, Color(0xFF2864C5)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _navy.withValues(alpha: 0.16),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned(
              right: -22,
              bottom: -44,
              child: Icon(
                Icons.local_offer_rounded,
                size: 160,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      'PROMO SPESIAL',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Penawaran spesial untukmu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      height: 1.2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Hemat lebih banyak untuk setiap pilihanmu.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 18,
              right: 18,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD166),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'DISKON 50%',
                  style: TextStyle(
                    color: _navy,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.nama,
    required this.nim,
    required this.prodiKelas,
  });

  final String nama;
  final String nim;
  final String prodiKelas;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 27,
            backgroundColor: const Color(0xFFEAF0FC),
            child: Text(
              nama.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                color: _blue,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: const TextStyle(
                    color: _navy,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                _ProfileDetail(icon: Icons.badge_outlined, text: 'NIM: $nim'),
                const SizedBox(height: 5),
                _ProfileDetail(icon: Icons.school_outlined, text: prodiKelas),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Color(0xFFF4B740),
                      size: 17,
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.star_rounded,
                      color: Color(0xFFF4B740),
                      size: 17,
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.star_rounded,
                      color: Color(0xFFF4B740),
                      size: 17,
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.star_rounded,
                      color: Color(0xFFF4B740),
                      size: 17,
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.star_rounded,
                      color: Color(0xFFF4B740),
                      size: 17,
                    ),
                    SizedBox(width: 6),
                    Text(
                      '5.0',
                      style: TextStyle(color: Color(0xFF718096), fontSize: 12),
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

class _ProfileDetail extends StatelessWidget {
  const _ProfileDetail({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15, color: const Color(0xFF8290A3)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Color(0xFF59677A), fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  static const int _price = 129000;
  int _quantity = 1;
  int _likes = 24;
  bool _isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      _likes += _isFavorite ? 1 : -1;
    });
  }

  void _addToCart() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$_quantity produk berhasil ditambahkan ke keranjang.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF0FC),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Icon(Icons.headphones_rounded, color: _blue, size: 88),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'ELEKTRONIK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton.filledTonal(
                  tooltip: _isFavorite
                      ? 'Hapus dari favorit'
                      : 'Tambahkan ke favorit',
                  onPressed: _toggleFavorite,
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite ? Colors.red : _navy,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Text(
            'Headphone Wireless',
            style: TextStyle(
              color: _navy,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.favorite, size: 16, color: Colors.redAccent),
              const SizedBox(width: 5),
              Text(
                '$_likes suka',
                style: const TextStyle(color: Color(0xFF718096), fontSize: 13),
              ),
              const Spacer(),
              const Text(
                'Harga satuan',
                style: TextStyle(color: Color(0xFF718096), fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            _formatRupiah(_price),
            style: const TextStyle(
              color: _blue,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Divider(height: 24),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Jumlah produk',
                  style: TextStyle(
                    color: Color(0xFF59677A),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton.filledTonal(
                tooltip: 'Kurangi jumlah',
                onPressed: _quantity > 1
                    ? () => setState(() => _quantity--)
                    : null,
                icon: const Icon(Icons.remove),
              ),
              SizedBox(
                width: 38,
                child: Text(
                  '$_quantity',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: _navy,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton.filledTonal(
                tooltip: 'Tambah jumlah',
                onPressed: () => setState(() => _quantity++),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F7FB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Total harga',
                    style: TextStyle(
                      color: Color(0xFF59677A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  _formatRupiah(_price * _quantity),
                  style: const TextStyle(
                    color: _navy,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 13),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _addToCart,
              style: FilledButton.styleFrom(
                backgroundColor: _blue,
                padding: const EdgeInsets.symmetric(vertical: 13),
              ),
              icon: const Icon(Icons.shopping_cart_outlined),
              label: const Text('Tambah ke Keranjang'),
            ),
          ),
        ],
      ),
    );
  }
}

String _formatRupiah(int amount) {
  final digits = amount.toString();
  final formatted = digits.replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (match) => '${match[1]}.',
  );
  return 'Rp $formatted';
}

class _SurfaceCard extends StatelessWidget {
  const _SurfaceCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE7ECF3)),
      ),
      child: Container(padding: const EdgeInsets.all(18), child: child),
    );
  }
}
