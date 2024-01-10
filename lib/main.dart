import 'package:duapuluhnolnol/screens/auth.dart';
import 'package:duapuluhnolnol/firebase_options.dart';
import 'package:duapuluhnolnol/screens/login_or_register.dart';
import 'package:duapuluhnolnol/screens/main_screen.dart';
import 'package:duapuluhnolnol/screens/profile_screen.dart';
import 'package:duapuluhnolnol/screens/user_screen.dart';
import 'package:duapuluhnolnol/theme/dark_mode.dart';
import 'package:duapuluhnolnol/theme/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, 
        home: const AuthScreen(),
        theme:lightMode,
        darkTheme: darkMode,
        routes: {
          "/login_or_register" :(context)=>const LoginOrRegister(),
          "/profile_screen" : (context)=> ProfileScreen(),
          "/users_screen" : (context)=> ChatListScreen(),
          "/main_screen" : (context) => MainScreen(),
          
        },
      );
  }
}
