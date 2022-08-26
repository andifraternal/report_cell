import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'home.dart';

void main() => runApp( const App());


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // themeMode: ThemeMode.dark, 
      
      theme: ThemeData(
        primaryColor: Colors.black, 
        scaffoldBackgroundColor: const Color.fromARGB(255, 136, 131, 131), 
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent, 
          elevation: 0
        )
      ),
      title: 'Report Cell',
      // initialRoute: (cekData()==true?'/home':'/'),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginApp(),
        '/home' : ((context) => const Home()),
      },
    );
  }
}