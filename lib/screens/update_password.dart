import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stable_hub_app/screens/login_screen.dart';
import 'package:stable_hub_app/providers/auth_provider.dart';
import 'package:stable_hub_app/widgets/password_field_text.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({
    super.key, required this.email
  });
  final String email;
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:Form(
          key: _formKey,
          child: Center(
            child:Padding(
              padding: const EdgeInsets.only(
                top: 100,
                bottom: 50,
                right: 30,
                left: 30,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Send OTP",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    AuthPasswordTextField(
                      hintText: "Enter new password",
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

                    const SizedBox(height: 20),
                    AuthPasswordTextField(
                      hintText: "Enter confirm password",
                      controller: _confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (_passwordController.text!= _confirmPasswordController.text) {
                          return 'new and confirm password is not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _updatePassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          Colors.blue, // Change the background color here
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        child: Consumer<AuthProvider>(builder: (_, provider, __) {
                          return provider.isLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                            "Change Password",
                            style: TextStyle(
                                fontSize: 16, color: Colors.black),
                          );
                        }),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void _updatePassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      bool password = (await context
          .read<AuthProvider>()
          .updatePassword(password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text, email: 'email'));

      if (password != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
      } else {
        print("Something went wrong");
      }
    }
  }
}
