import 'package:en_learn/providers/backend.dart';
import 'package:en_learn/screens/ai_menu_tools_screen.dart';
import 'package:en_learn/screens/ai_tools_screen.dart';
import 'package:en_learn/screens/ai_translate_screen.dart';
import 'package:en_learn/screens/profile_screen.dart';

import 'package:en_learn/screens/screens.dart';
import 'package:en_learn/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => BackendProvider())
        ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CbaTalk",
      initialRoute: 'login',
      navigatorKey: navigatorKey,
      routes: {
        'check_auth_screen': (_) => const CheckAuthScreen(),
        'login': (_) => const LoginScreen(),
        'home': (_) => const RoutesApp(),
        'ai_menu': (_) => const AiToolsMenuScreen(),
        'ai_translate': (_) => const AiToolsScreen( screen: AiTranslateScreen(), title: 'Tools gramatical',),
        'ai_conversation': (_) => const AiToolsScreen( screen: AiConversationScreen( ), title: 'Conversation' ),
        'ai_check_grammar': (_) => const AiToolsScreen( screen: AiCheckGrammarScreen(), title: 'Check Grammar', ),
        'profile':(_) => const ProfileScreen(),
        'placement_test': (_) => const PlacementTest(),
      },
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.kalamTextTheme(Theme.of(context)
            .textTheme), // Establece Kalam como la fuente predeterminada
        // Otros estilos de tema si los tienes
      ),
    );
  }
}
//DG2-2
//DG2-3
//DG2-5
//DG2-6
//DG2-7
//DG2-8
//DG2-13
//DG2-14
//DG2-15
//DG2-19
