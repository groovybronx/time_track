import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:time_track/main.dart';

void main() {
  testWidgets('TimeTrackApp renders AppShell', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: TimeTrackApp(),
      ),
    );
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
