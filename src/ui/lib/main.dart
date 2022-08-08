import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topographe/config/styles.dart';
import 'package:topographe/config/config.dart';
import 'package:topographe/models/client.dart';
import 'package:topographe/models/document.dart';
import 'package:topographe/models/financement.dart';
import 'package:topographe/screens/home_screen.dart';
import 'package:topographe/screens/login_screen.dart';


main() => runApp(
  MultiProvider(
    providers: [
      Provider<Client>(create: (context) => Client()),
      Provider<Document>(create: (context) => Document()),
      Provider<Financement>(create: (context) => Financement()),
    ],
    child: MaterialApp(
      title: name,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: Fonts.primary,
        primaryColor: Colors_.primaryLightBg, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors_.accent)
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),  
        '/': (context) => const HomeScreen()
      },
    ),
  )
);
