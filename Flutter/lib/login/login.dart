import 'package:flutter/material.dart';
import 'package:assistantmemo/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:assistantmemo/shared/BottomNavBar';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const FlutterLogo(
              size: 150,
            ),
            Center(child: Text("Welcome to Assistant Memo")),
            Center(
                child:
                    Text("Alessandro Ciccolella\nEric Piasentin\nVraj Patel")),
            // Center(child: Text("Eric Piasentin")),
            // Center(child: Text("Vraj Patel")),
            LoginButton(
              text: 'Sign in with Google',
              icon: FontAwesomeIcons.google,
              color: Colors.blue,
              loginMethod: AuthService().googleLogin,
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final Function loginMethod;

  const LoginButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.color,
      required this.loginMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: color,
        ),
        onPressed: () => loginMethod(),
        label: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}
