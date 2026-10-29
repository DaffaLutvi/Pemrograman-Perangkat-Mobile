import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_sesi_5/main.dart';

void main() {
  testWidgets('shows the three NusaEvent Hub tabs', (tester) async {
    await tester.pumpWidget(const NusaEventHubApp());

    expect(find.text('NusaEvent Hub'), findsOneWidget);
    expect(find.text('Seminar & Workshop'), findsOneWidget);
    expect(find.text('AI for Everyone: Dari Ide ke Inovasi'), findsOneWidget);

    await tester.tap(find.text('Galeri & Denah'));
    await tester.pumpAndSettle();
    expect(find.text('Poster seminar'), findsOneWidget);
    expect(find.text('Denah venue'), findsOneWidget);

    await tester.tap(find.text('Tiket'));
    await tester.pumpAndSettle();
    expect(find.text('Belum ada tiket'), findsOneWidget);
  });

  testWidgets('opens the validated registration form from an event card',
      (tester) async {
    await tester.pumpWidget(const NusaEventHubApp());
    await tester.tap(find.text('AI for Everyone: Dari Ide ke Inovasi'));
    await tester.pumpAndSettle();

    expect(find.text('Pendaftaran seminar'), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.text('Nama lengkap'), findsOneWidget);
    expect(find.text('Nomor WhatsApp'), findsOneWidget);
  });

  testWidgets('renders gallery on a narrow screen without layout overflow',
      (tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const NusaEventHubApp());
    await tester.tap(find.text('Galeri & Denah'));
    await tester.pumpAndSettle();

    expect(find.text('Poster seminar'), findsOneWidget);
    expect(find.text('Denah venue'), findsOneWidget);
  });
}
