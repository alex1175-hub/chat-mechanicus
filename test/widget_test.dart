import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:menus/main.dart';

void main() {
  testWidgets('Bottom navigation opens people, chats, and calls', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Peoples'), findsWidgets);
    expect(find.text('Belisarius Cawl'), findsOneWidget);

    await tester.tap(find.text('Chats').last);
    await tester.pumpAndSettle();
    expect(find.text('TRANSMISIONES NOOSFÉRICAS'), findsOneWidget);
    expect(find.text('Los datos del STC han sido purgados.'), findsOneWidget);

    await tester.tap(find.text('Calls').last);
    await tester.pumpAndSettle();
    expect(find.text('REGISTRO DE COMUNICACIONES'), findsOneWidget);
    expect(find.text('Llamada perdida'), findsOneWidget);
  });

  testWidgets('Search filters the selected directory', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byKey(const Key('directory-search')), 'Mira');
    await tester.pumpAndSettle();

    expect(find.text('Mira-Omicron'), findsOneWidget);
    expect(find.text('Belisarius Cawl'), findsNothing);
    expect(find.text('1 FILES'), findsOneWidget);
  });
}
