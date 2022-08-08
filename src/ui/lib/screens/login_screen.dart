import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topographe/config/styles.dart';
import 'package:topographe/config/config.dart';
import 'package:topographe/widgets/layout.dart';
import 'package:topographe/widgets/logo.dart';
import 'package:topographe/widgets/field.dart';
import 'package:topographe/widgets/button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';
  String? token = '';
  String email = '';
  
  Widget build(BuildContext context) {
    void login() {
      post(Uri.parse(url + '/api/accounts/login/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },  
        body: jsonEncode(<String, String>{
          'username': username,
          'email': email,
          'password': password
        }
      ))
      .then((response) {
        if (response.statusCode == 200) {
          setState(() => token = jsonDecode(response.body)['key']);

          SharedPreferences.getInstance()
          .then((preferences) { 
            preferences.setString('username', username);
            preferences.setString('token', token.toString());
          });

          Navigator.pushNamed(context, '/');
        }
      });
    }

    return LayoutBuilder(
      builder: (context, constraints) => Layout(
        top: true,
        right: true,
        bottom: true,
        left: true,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Container(
            width: constraints.maxWidth > 420.0 ? 400.0 : 300.0,
            height: 460.0,
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0, 
              vertical: 30.0
            ),
            decoration: BoxDecoration(
              color: Colors_.primaryLightBg,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: const [
                Shadows.light
              ]
            ),
            child: Column(
              children: [
                const Logo(
                  image: 'assets/images/logo.png',
                  width: 150.0,
                  height: 150.0
                ),
                const SizedBox(
                  height: 24.0
                ),
                Field(
                  label: "Nom d'utilisateur:",
                  onChanged: (value) => setState(() => username = value),
                  labelFontSize: 15.0,
                  labelFontWeight: FontWeight.w500,
                  labelFontColor: Colors_.primaryLightFont,
                  cursorColor: Colors_.primaryLightFont,
                  keyboardType: TextInputType.text,
                  fillColor: Colors_.primaryLightFont,
                  hintText: "Votre nom d'utilisateur",
                  fontSize: 15.0
                ),
                const SizedBox(
                  height: 16.0
                ),
                Field(
                  label: 'Mot de passe:',
                  onChanged: (value) => setState(() => password = value),
                  labelFontSize: 15.0,
                  labelFontWeight: FontWeight.w500,
                  labelFontColor: Colors_.primaryLightFont,
                  cursorColor: Colors_.primaryLightFont,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  obscureText: true,
                  fillColor: Colors_.primaryLightFont,
                  hintText: "Votre mot de passe",
                  fontSize: 15.0,
                  onSubmitted: (value) => login()
                ),
                const SizedBox(
                  height: 16.0
                ),
                Button(
                  title: 'Connexion', 
                  color: Colors_.accent,
                  fontColor: Colors_.quaternaryLightFont,
                  fontWeight: FontWeight.w500,
                  height: 40.0,
                  radius: BorderRadius.circular(5.0),
                  onTap: login
                ),
              ]
            )
          ),
        )
      )
    );
  }
}
