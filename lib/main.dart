import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:stable_hub_app/providers/auth_provider.dart";
import "package:stable_hub_app/screens/splash_screen.dart";

//FUNCTION EXPRESSION
void main() {
  runApp(const MyFlutterApp());
}

class MyFlutterApp extends StatelessWidget {
  const MyFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title:"Stable Hub",
          home: SplashScreen(),
      ),
    );
  }
}
