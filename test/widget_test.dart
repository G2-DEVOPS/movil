// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:en_learn/screens/login_screen.dart';
import 'package:en_learn/providers/login_form_provider.dart';
import 'package:provider/provider.dart';

void main() {
  group('LoginScreen Widget Tests', () {
    // Test 1: Verificar que todos los elementos se renderizan correctamente
    testWidgets('Poder renderizar todos los elementos iniciales correctamente', (WidgetTester tester) async {
      // ARRANGE
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (_) => LoginFormProvider(),
            child: const LoginScreen(),
          ),
        ),
      );

      // ASSERT
      expect(find.text('Bienvenido'), findsOneWidget);
      expect(find.text('Ingresa tus datos'), findsOneWidget);
      expect(find.byKey(const Key('email_field')), findsOneWidget);
      expect(find.byKey(const Key('password_field')), findsOneWidget);
      expect(find.byKey(const Key('login_button')), findsOneWidget);
      expect(find.text('Olvide mi contraseña'), findsOneWidget);
    });

    // Test 2: Validación de formulario con campos vacíos
    testWidgets('Poder mostrar errores de validación en campos vacíos', (WidgetTester tester) async {
      // ARRANGE
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (_) => LoginFormProvider(),
            child: const LoginScreen(),
          ),
        ),
      );

      // ACT
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pump();

      // ASSERT
      expect(find.text('Ingrese un correo valido'), findsOneWidget);
      expect(find.text('la contraseña debe ser mayor a 6 caracteres'), findsOneWidget);
    });

    // Test 3: Validación de email inválido
    testWidgets('Poder ver email de validación de error para emails enválidos', (WidgetTester tester) async {
      // ARRANGE
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (_) => LoginFormProvider(),
            child: const LoginScreen(),
          ),
        ),
      );

      // ACT
      await tester.enterText(find.byKey(const Key('email_field')), 'invalid-email');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pump();

      // ASSERT
      expect(find.text('Ingrese un correo valido'), findsOneWidget);
    });

    // // Test 4: Validación de contraseña corta
    testWidgets('Poder ver validación de error en contraseñas cortas', (WidgetTester tester) async {
      // ARRANGE
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (_) => LoginFormProvider(),
            child: const LoginScreen(),
          ),
        ),
      );

      // ACT
      await tester.enterText(find.byKey(const Key('password_field')), '123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pump();

      // ASSERT
      expect(find.text('la contraseña debe ser mayor a 6 caracteres'), findsOneWidget);
    });
  });
}