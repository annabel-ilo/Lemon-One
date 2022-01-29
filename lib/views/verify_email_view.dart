import 'package:flutter/material.dart';
import 'package:lemon_one/constants/route.dart';
import 'package:lemon_one/services/auth/auth_service.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                "A Verification mail have been sent to your email, Please open it to verift your account"),
            const SizedBox(height: 50.0),
            const Text(
              "If you haven't received the verification email, Press the button below",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20.0),
            TextButton(
                onPressed: () async {
                  await AuthService.firebase().sendEmailVerification();
                },
                child: const Text(
                  'send email verification',
                  style: TextStyle(fontSize: 15),
                )),
            TextButton(
              onPressed: () async {
                await AuthService.firebase().logout();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              child: const Text('Reset'),
            )
          ],
        ),
      ),
    );
  }
}
