import 'package:registro_memorias/screens/loginScreen.dart';
import 'package:registro_memorias/screens/places.dart';
import 'package:registro_memorias/screens/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final theme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    const ProviderScope(child: MyApp()), 
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lugares Favoritos',
      theme: theme,
      initialRoute: '/',
      routes: {
        '/': (context) =>  LoginScreen(), 
        '/places': (context) => const PlacesScreen(),
        '/register': (context) =>  RegisterScreen(), 
      },
    );
  }
}

class LaunchPage extends StatelessWidget {
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text("Aplicativo Lugares Favoritos", 
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primaryContainer,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 40),
            const Image(
              image: AssetImage('assets/location_logo.png'),
              height: 150,
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/places');
              }, 
              label: const Text("Vamos começar...", style: TextStyle(fontSize: 20)),
              icon: const Icon(Icons.arrow_forward),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
          ],
        ),
      ).animate()
        .fade(delay: 50.ms, duration: 1200.ms)
        .move(begin: const Offset(0, 30), end: Offset.zero),
    );
  }
}
