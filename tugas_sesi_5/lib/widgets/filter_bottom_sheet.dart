import 'package:flutter/material.dart';

import '../data/sample_events.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({required this.selectedCategory, super.key});

  final String selectedCategory;

  static Future<String?> show(
    BuildContext context, {
    required String selectedCategory,
  }) {
    return showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (_) =>
          FilterBottomSheet(selectedCategory: selectedCategory),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['Semua', ...eventCategories];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter kategori',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 16),
            ...categories.map((category) {
              final isSelected = selectedCategory == category;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(category),
                trailing: isSelected
                    ? const Icon(Icons.check_circle, color: Color(0xFF147D78))
                    : null,
                onTap: () => Navigator.pop(context, category),
              );
            }),
          ],
        ),
      ),
    );
  }
}
