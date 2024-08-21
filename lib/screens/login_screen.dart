import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:stable_hub_app/providers/auth_provider.dart";
import "package:stable_hub_app/screens/send_otp.dart";
import "package:stable_hub_app/screens/sign_up.dart";
import "package:stable_hub_app/widgets/auth_text_field.dart";
import "package:stable_hub_app/widgets/password_field_text.dart";

import "first_screen.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 100,
              bottom: 50,
              right: 30,
              left: 30,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Log In",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  AuthTextField(
                    hintText: "Enter your Email Address",
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email address';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter the valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  AuthPasswordTextField(
                      hintText: "Enter password",
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        } else {
                          if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value)) {
                            return 'Enter valid password';
                          } else {
                            return null;
                          }
                        }
                      }
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.blue, // Change the background color here
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child:  Consumer<AuthProvider>(
                        builder: (_, provider, __) {
                          return provider.isLoading ? const CircularProgressIndicator()  : const Text(
                            "Log In",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          );
                        }
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SendOtp()),
                    );
                  },
                child: const Text(
                  "Forget Password?",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 17,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
                const SizedBox(
                  height: 10,
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have account",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()),
                          );
                        },
                        child: const Text(
                          "Signup",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
  // Future<bool> fetchUser() async => await context.read<AuthProvider>().login(email, password);

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      bool isLoggedIn = await context
          .read<AuthProvider>()
          .login(_emailController.text, _passwordController.text);

      if (isLoggedIn) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => FirstScreen(),
            ));
      } else {
        print("Something went wrong");
      }
    }
  }
}
