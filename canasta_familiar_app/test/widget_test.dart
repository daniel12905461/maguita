import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:canasta_familiar_app/main.dart';
import 'package:canasta_familiar_app/providers/auth_provider.dart';
import 'package:canasta_familiar_app/providers/user_provider.dart';

void main() {
  testWidgets('Canasta Familiar renders splash', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: const CanastaFamiliarApp(),
      ),
    );
    await tester.pump();

    expect(find.text('Canasta Familiar'), findsWidgets);
  });
}