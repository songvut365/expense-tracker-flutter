import 'package:expense_tracker/src/screens/home.dart';
import 'package:expense_tracker/src/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import './src/screens/login.dart';
import './src/theme/default.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MaterialApp(
    theme: defaultTheme,
    home: const Login(),
    routes: {
      '/signup': (context) => const Signup(),
      '/login': (context) => const Login(),
      '/home': (context) => const Home(title: 'John Doe', location: 'Bangkok')
    },
  ));
}
