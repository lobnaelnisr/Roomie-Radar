import 'package:flutter/material.dart';
import 'package:roomie_radar/firebase_options.dart';
import 'package:roomie_radar/utils/app_theme.dart';
import 'package:roomie_radar/views/authentication/signInScreen.dart';
import 'package:roomie_radar/views/authentication/signUpScreen.dart';
import 'package:roomie_radar/views/listings/room_listing.dart';
// import 'package:roomie_radar/views/auth/signInScreen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeData.lightTheme,
      initialRoute: '/signUp',
      routes: {
        '/signIn': (context) => const SignInScreen(),
        '/signUp': (context) => const SignUpScreen(),
        '/roomListing': (context) => const RoomListing(),
      },
    );
  }
}
