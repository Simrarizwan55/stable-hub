import "package:country_picker/country_picker.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:stable_hub_app/providers/auth_provider.dart";
import "package:stable_hub_app/screens/verify_otp.dart";
import "package:stable_hub_app/widgets/auth_text_field.dart";
import "package:stable_hub_app/widgets/password_field_text.dart";

import "../../screens/login_screen.dart";

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();
  Country? selectedCountry;
  final _countryController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
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
                  "Sign Up",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                 AuthTextField(
                  hintText: "Enter your full name",
    controller: _fullNameController,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your full name';
      }
      return null;
    }
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                AuthTextField(
                  hintText: "Enter Phone Number",
                  controller: _phoneNumController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your phone number';
                    }
                    if (value.length < 10 || value.length > 10) {
                      return " Phone Number must be of 10 digits";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      onSelect: (Country country) {
                        setState(() {
                          selectedCountry = country;
                          _countryController.text =
                              country.name;
                        });
                      },
                    );
                  },
                  child: TextField(
                    enabled: false,
                    controller: _countryController,
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                    decoration: InputDecoration(
                      hintText: "Country selection",
                      hintStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                            color: Colors.white54, width: 10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.white54, width: 2.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _signup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue, // Change the background color here
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: Consumer<AuthProvider>(builder: (_, provider, __) {
                      return provider.isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Sign Up",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            );
                    }),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already Login?",
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
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 17,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signup() async {
    if(selectedCountry == null) {
      print("select country");
      return;
    }
    if (_formKey.currentState?.validate() ?? false) {
      String? id = await context.read<AuthProvider>().signUp(
          email: _emailController.text,
          password: _passwordController.text,
          fullName: _fullNameController.text,
          country: _countryController.text,
          countryCode: selectedCountry!.phoneCode,
          phone: _phoneNumController.text);

      if (id != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyOtp(
                userId: id,
              ),
            ));
      } else {
        print("Something went wrong");
      }
    }
  }
}
