// This is a basic Flutter widget test for NSC1 Secure Door app.

import 'package:flutter_test/flutter_test.dart';

import 'package:nsc1_mobileapp/main.dart';

void main() {
  testWidgets('NSC1 App loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NSC1App());

    // Verify that the main title is displayed.
    expect(find.text('NSC1 SECURE DOOR'), findsOneWidget);

    // Verify that the two main buttons are present.
    expect(find.text("J'ai oublié mon badge"), findsOneWidget);
    expect(find.text("Je veux m'inscrire"), findsOneWidget);

    // Verify that the contact text is present.
    expect(find.text('Contactez-nous :'), findsOneWidget);
  });

  testWidgets('Navigation to login page works', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NSC1App());

    // Tap the login button.
    await tester.tap(find.text("J'ai oublié mon badge"));
    await tester.pumpAndSettle();

    // Verify that we navigated to the login page.
    expect(find.text('Connectez-vous avec vos identifiants'), findsOneWidget);
    expect(find.text('Déverrouiller la porte'), findsOneWidget);
  });

  testWidgets('Navigation to register page works', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NSC1App());

    // Tap the register button.
    await tester.tap(find.text("Je veux m'inscrire"));
    await tester.pumpAndSettle();

    // Verify that we navigated to the register page.
    expect(find.text('Demande de Badge d\'Accès'), findsOneWidget);
    expect(
      find.text(
        'Remplissez ce formulaire pour obtenir vos identifiants et accès au bâtiment',
      ),
      findsOneWidget,
    );
  });
}
