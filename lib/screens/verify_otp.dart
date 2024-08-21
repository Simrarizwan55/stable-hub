import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stable_hub_app/screens/first_screen.dart';
import 'package:stable_hub_app/providers/auth_provider.dart';
import 'package:stable_hub_app/screens/update_password.dart';
import 'package:stable_hub_app/widgets/password_field_text.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({
    super.key,
    required this.userId,
    this.isForgetPasswordCase = false,
  });

  final String userId;
  final bool isForgetPasswordCase;

  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

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
                    "Verify OTP",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  AuthPasswordTextField(
                    hintText: "Enter OTP",
                    controller: _otpController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter OTP';
                      }
                      if (value.length != 5) {
                        return "OTP must be of 5 digits";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.blue, // Change the background color here
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: Consumer<AuthProvider>(builder: (_, provider, __) {
                        return provider.isLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                "Verify OTP",
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

  void _verifyOtp() async {
    if (_formKey.currentState?.validate() ?? false) {
      String? email = (await context
          .read<AuthProvider>()
          .otpVerify(otp: _otpController.text, userId: widget.userId));

      if (email != null) {
        if(widget.isForgetPasswordCase) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => UpdatePassword(email: email),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FirstScreen(),
              ));
        }
      } else {
        print("Something went wrong");
      }
    }
  }
}
