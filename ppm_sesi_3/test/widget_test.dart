import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ppm_sesi_3/main.dart';
import 'package:ppm_sesi_3/providers/cart_provider.dart';
import 'package:ppm_sesi_3/providers/theme_provider.dart';
import 'package:provider/provider.dart';

Widget createTestApp() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ],
    child: const NusaBookstoreApp(),
  );
}

void main() {
  testWidgets('cart updates quantities, totals, badge, and checkout',
      (tester) async {
    await tester.pumpWidget(createTestApp());

    await tester.tap(find.byKey(const Key('add-bumi')));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byKey(const Key('open-cart')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('quantity-bumi')), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(const Key('total-price')),
        matching: find.text('Rp105.000'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byKey(const Key('total-items')),
        matching: find.text('1'),
      ),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const Key('increase-bumi')));
    await tester.pump();
    expect(
      find.descendant(
        of: find.byKey(const Key('quantity-bumi')),
        matching: find.text('2'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byKey(const Key('total-price')),
        matching: find.text('Rp210.000'),
      ),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const Key('decrease-bumi')));
    await tester.pump();
    expect(
      find.descendant(
        of: find.byKey(const Key('total-price')),
        matching: find.text('Rp105.000'),
      ),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const Key('checkout')));
    await tester.pump();
    expect(find.text('Checkout berhasil: Rp105.000'), findsOneWidget);
    expect(find.text('Keranjang masih kosong'), findsOneWidget);
    expect(find.text('Rp0'), findsOneWidget);
  });

  testWidgets('theme toggle applies dark mode throughout the app',
      (tester) async {
    await tester.pumpWidget(createTestApp());

    await tester.tap(find.byKey(const Key('toggle-theme')));
    await tester.pump();
    var app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.dark);

    await tester.tap(find.byKey(const Key('open-cart')));
    await tester.pumpAndSettle();
    app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.dark);
  });
}
