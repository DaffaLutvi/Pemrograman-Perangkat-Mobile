import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/cart_provider.dart';

String _formatRupiah(int amount) {
  final digits = amount.toString();
  final formatted = digits.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => '.',
  );
  return 'Rp$formatted';
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final entries = cart.items.entries.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang Belanja')),
      body: Column(
        children: [
          Expanded(
            child: entries.isEmpty
                ? const Center(child: Text('Keranjang masih kosong'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      return _CartBookCard(
                        book: entry.key,
                        quantity: entry.value,
                      );
                    },
                  ),
          ),
          _CartSummary(
            totalItems: cart.totalItems,
            totalPrice: cart.totalPrice,
          ),
        ],
      ),
    );
  }
}

class _CartBookCard extends StatelessWidget {
  const _CartBookCard({required this.book, required this.quantity});

  final Book book;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const CircleAvatar(child: Icon(Icons.menu_book)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book.title, style: Theme.of(context).textTheme.titleSmall),
                  Text(_formatRupiah(book.price)),
                ],
              ),
            ),
            IconButton(
              key: Key('decrease-${book.id}'),
              tooltip: 'Kurangi ${book.title}',
              onPressed: () => context.read<CartProvider>().removeItem(book),
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Text('$quantity', key: Key('quantity-${book.id}')),
            IconButton(
              key: Key('increase-${book.id}'),
              tooltip: 'Tambah ${book.title}',
              onPressed: () => context.read<CartProvider>().addItem(book),
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartSummary extends StatelessWidget {
  const _CartSummary({required this.totalItems, required this.totalPrice});

  final int totalItems;
  final int totalPrice;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Item'),
                Text('$totalItems', key: const Key('total-items')),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Pembayaran'),
                Text(
                  _formatRupiah(totalPrice),
                  key: const Key('total-price'),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            FilledButton(
              key: const Key('checkout'),
              onPressed: totalItems == 0
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Checkout berhasil: ${_formatRupiah(totalPrice)}',
                          ),
                        ),
                      );
                      context.read<CartProvider>().clearCart();
                    },
              child: const Text('Checkout / Bayar'),
            ),
          ],
        ),
      ),
    );
  }
}
