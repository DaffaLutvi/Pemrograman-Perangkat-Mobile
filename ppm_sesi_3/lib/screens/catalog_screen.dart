import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';
import 'cart_screen.dart';

const _books = [
  Book(
    id: 'bumi',
    title: 'Laut Bercerita',
    author: 'Leila S. Chudori',
    price: 105000,
  ),
  Book(
    id: 'pulang',
    title: 'Pulang',
    author: 'Tere Liye',
    price: 89000,
  ),
  Book(
    id: 'filosofi',
    title: 'Filosofi Teras',
    author: 'Henry Manampiring',
    price: 98000,
  ),
  Book(
    id: 'bumimanusia',
    title: 'Bumi Manusia',
    author: 'Pramoedya Ananta Toer',
    price: 120000,
  ),
  Book(
    id: 'atomic',
    title: 'Atomic Habits',
    author: 'James Clear',
    price: 115000,
  ),
];

String _formatRupiah(int amount) {
  final digits = amount.toString();
  final formatted = digits.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => '.',
  );
  return 'Rp$formatted';
}

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final totalItems = context.watch<CartProvider>().totalItems;
    final isDarkMode = context.watch<ThemeProvider>().isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('NusaBookstore'),
        actions: [
          IconButton(
            key: const Key('toggle-theme'),
            tooltip: isDarkMode ? 'Light Mode' : 'Dark Mode',
            onPressed: () => context.read<ThemeProvider>().toggleTheme(),
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
          ),
          IconButton(
            key: const Key('open-cart'),
            tooltip: 'Keranjang',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const CartScreen()),
            ),
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart_outlined),
                if (totalItems > 0)
                  Positioned(
                    right: -8,
                    top: -8,
                    child: Container(
                      key: const Key('cart-badge'),
                      padding: const EdgeInsets.all(4),
                      constraints:
                          const BoxConstraints(minWidth: 18, minHeight: 18),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.error,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$totalItems',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onError,
                          fontSize: 11,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _books.length,
        itemBuilder: (context, index) {
          final book = _books[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    child: book.imageUrl == null
                        ? const Icon(Icons.menu_book)
                        : ClipOval(
                            child: Image.network(
                              book.imageUrl!,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) =>
                                  const Icon(Icons.menu_book),
                            ),
                          ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(book.author),
                        const SizedBox(height: 4),
                        Text(
                          _formatRupiah(book.price),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FilledButton.tonalIcon(
                          key: Key('add-${book.id}'),
                          onPressed: () =>
                              context.read<CartProvider>().addItem(book),
                          icon: const Icon(Icons.add_shopping_cart),
                          label: const Text('Tambah ke Keranjang'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
