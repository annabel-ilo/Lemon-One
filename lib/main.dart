import 'package:flutter/material.dart';
import 'package:lemon_one/constants/route.dart';
import 'package:lemon_one/services/auth/auth_service.dart';
import 'package:lemon_one/views/login_view.dart';
import 'package:lemon_one/views/notes/new_note_view.dart';
import 'package:lemon_one/views/notes/notes_view.dart';
import 'package:lemon_one/views/register_view.dart';
import 'package:lemon_one/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        newNoteRoute: (context) => const NewNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          // if (user?.emailVerified ?? false) {
          //   return const Text('Done');
          // } else {
          //   return const VerifyEmailView();
          // }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
