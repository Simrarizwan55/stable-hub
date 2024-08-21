import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:stable_hub_app/screens/login_screen.dart";
import "package:stable_hub_app/providers/auth_provider.dart";
import "package:stable_hub_app/screens/update_profile.dart";

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (_, provider, __) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(provider.user?.name ?? "Error",style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () {
                      provider.logout();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                        (_) => false,
                      );
                    },
                    child: Text(
                      "LOGOUT",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(height: 60),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateProfile()
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue, // Change the background color here
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: Consumer<AuthProvider>(builder: (_, provider, __) {
                      return provider.isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Update Profile",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            );
                    }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
