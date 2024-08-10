import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class ProfilePage extends NyStatefulWidget {
  static const path = '/profile';

  ProfilePage({super.key}) : super(path, child: () => _ProfilePageState());
}

class _ProfilePageState extends NyState<ProfilePage> {
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
      appBar: AppBar(title: Text("Profile")),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          color: Colors.amber[600],
          // width: 48.0,
          // height: 48.0,
          child: Text('Awesome'),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
