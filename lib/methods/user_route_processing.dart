import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/landing_page.dart';
import '../pages/main_page.dart';

// class untuk meneruskan user ke halaman utama jika berhasil login
// jika tidak sedang login akan kembali ke landing page
class UserRouteProcessing extends StatelessWidget {
  const UserRouteProcessing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return MainPage();
            } else {
              return const LandingPage();
            }
          }),
    );
  }
}
