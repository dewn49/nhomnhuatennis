import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';

class LoginPage extends NyStatefulWidget {
  static const path = '/login';

  LoginPage({super.key}) : super(path, child: () => _LoginPageState());
}

class _LoginPageState extends NyState<LoginPage> {
  @override
  init() async {}

  /// Use boot if you need to load data before the [view] is rendered.
  // @override
  // boot() async {
  //
  // }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Login",
        style: GoogleFonts.workSans(
          textStyle: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 255, 209, 84),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
          ),
        ),
      )),
      backgroundColor: Color.fromARGB(255, 61, 61, 61),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
