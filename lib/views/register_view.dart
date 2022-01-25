import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterView();
}

class _RegisterView extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: true,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Enter your email'),
          ),
          TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            controller: _password,
            decoration: const InputDecoration(hintText: 'Enter your password'),
          ),
          ElevatedButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: email, password: password);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak password') {
                  devtools.log('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  devtools.log('An account already exists for this email.');
                } else if (e.code == 'invalid-email') {
                  devtools.log('Use a valid email');
                }
              } catch (e) {
                devtools.log(e.toString());
              }
            },
            child: const Text(
              'Register',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 10.0),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/login/", (route) => false);
            },
            child: const Text(
              'Already registered? Login here',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
