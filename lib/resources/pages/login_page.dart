import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class LoginPage extends NyStatefulWidget {
  static const path = '/login';
  
  LoginPage({super.key}) : super(path, child: () => _LoginPageState());
}

class _LoginPageState extends NyState<LoginPage> {

  @override
  init() async {

  }
  
  /// Use boot if you need to load data before the [view] is rendered.
  // @override
  // boot() async {
  //
  // }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login")
      ),
      body: SafeArea(
         child: Container(),
      ),
    );
  }
}
