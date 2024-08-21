import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stable_hub_app/screens/first_screen.dart';
import 'package:stable_hub_app/providers/auth_provider.dart';
import 'package:stable_hub_app/screens/verify_otp.dart';
import 'package:stable_hub_app/widgets/auth_text_field.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    AuthProvider provider = context.read<AuthProvider>();
    if (provider.user != null) {
      _fullNameController.text = provider.user!.name ?? '';
      _phoneController.text = provider.user!.phone ?? '';
    }
  }

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
                    "Update Profile",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  AuthTextField(
                    hintText: "Enter Full Name ",
                    controller: _fullNameController,
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  AuthTextField(
                    hintText: "Enter Phone number",
                    controller: _phoneController,
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _updateProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.blue, // Change the background color here
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: Consumer<AuthProvider>(
                        builder: (_, provider, __) {
                          return provider.isLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  "Update Profile",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                );
                        },
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  void _updateProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      bool success = (await context.read<AuthProvider>().updateProfile(
          phone: _phoneController.text, fullName: _fullNameController.text));

      if (success) {
        Navigator.pop(
          context,
          // MaterialPageRoute(
          //   builder: (context) => FirstScreen(),
          // )
        );
      } else {
        print("Something went wrong");
      }
    }
  }
}
