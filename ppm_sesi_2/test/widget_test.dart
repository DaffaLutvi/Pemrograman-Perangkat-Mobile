import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ppm_sesi_2/main.dart';

void main() {
  testWidgets('product favorite, quantity, total, and cart controls work', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('PPM Sesi 2 - $nama ($nim)'), findsOneWidget);
    expect(find.byIcon(Icons.star_rounded), findsNWidgets(5));
    await tester.ensureVisible(find.text('Headphone Wireless'));
    await tester.pumpAndSettle();

    expect(find.text('24 suka'), findsOneWidget);
    expect(find.text('Rp 129.000'), findsNWidgets(2));
    expect(
      tester
          .widget<IconButton>(
            find.ancestor(
              of: find.byTooltip('Kurangi jumlah'),
              matching: find.byType(IconButton),
            ),
          )
          .onPressed,
      isNull,
    );

    await tester.tap(find.byTooltip('Tambahkan ke favorit'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Hapus dari favorit'), findsOneWidget);
    expect(find.text('25 suka'), findsOneWidget);

    await tester.tap(find.byTooltip('Tambah jumlah'));
    await tester.pumpAndSettle();
    expect(find.text('2', skipOffstage: false), findsOneWidget);
    expect(find.text('Rp 258.000'), findsOneWidget);

    await tester.ensureVisible(find.text('Tambah ke Keranjang'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tambah ke Keranjang'));
    await tester.pumpAndSettle();
    expect(
      find.text('2 produk berhasil ditambahkan ke keranjang.'),
      findsOneWidget,
    );
  });
}
