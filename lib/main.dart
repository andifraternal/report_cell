import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'home.dart';

void main() => runApp( App());


class App extends StatelessWidget {
  App({super.key});

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
      title: 'Flutter + PHP CRUD',
      // initialRoute: (cekData()==true?'/home':'/'),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginApp(),
        '/home' : ((context) => Home()),
      },
    );
  }
}