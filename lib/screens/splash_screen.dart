import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stable_hub_app/screens/first_screen.dart';
import 'package:stable_hub_app/screens/login_screen.dart';
import 'package:stable_hub_app/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 1),
      () {
        timer();
      },
    );
  }

  void timer() async {
    bool findUser = await fetchUser();
    if (findUser) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FirstScreen(),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Image.asset(
          "assets/images/hub_splash_screen.png",
          height: 200,
          width: 700,
        ),
      ),
    );
  }

  Future<bool> fetchUser() async => await context.read<AuthProvider>().fetchUser();


}
