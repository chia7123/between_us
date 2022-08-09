import 'package:between_us/provider/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.pink[400],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Between Us',
                style: TextStyle(fontSize: 50, color: Colors.white),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.6, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin();
                },
                icon: const FaIcon(FontAwesomeIcons.google),
                label: const Text("Sign In with Google"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
