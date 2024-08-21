import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stable_hub_app/providers/auth_provider.dart';
import 'package:stable_hub_app/screens/verify_otp.dart';
import 'package:stable_hub_app/widgets/auth_text_field.dart';
import 'package:stable_hub_app/widgets/password_field_text.dart';

class SendOtp extends StatefulWidget {
  const SendOtp({super.key});
  @override
  _SendOtpState createState() => _SendOtpState();
}

class _SendOtpState extends State<SendOtp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 50,
              bottom: 50,
              right: 30,
              left: 30,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
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
                  AuthTextField(
                    hintText: "Enter Email Address",
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
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _sendOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.blue, // Change the background color here
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child:
                          Consumer<AuthProvider>(builder: (_, provider, __) {
                        return provider.isLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                "Send OTP",
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
    );
  }

  void _sendOtp() async {
    if (_formKey.currentState?.validate() ?? false) {
      String? id = (await context
          .read<AuthProvider>()
          .sendOtp(email: _emailController.text));

      if (id != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyOtp(
                userId: id,
                isForgetPasswordCase: true,
              ),
            ));
      } else {
        print("Something went wrong");
      }
    }
  }
}
