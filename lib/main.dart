import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/bootstrap/app.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'bootstrap/boot.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Nylo nylo = await Nylo.init(setup: Boot.nylo, setupFinished: Boot.finished);
//LOCAL
  // await Supabase.initialize(
  //   url: 'http://127.0.0.1:54321',
  //   anonKey:
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0',
  // );

// CLOUD
  await Supabase.initialize(
    url: 'https://arzahjayxvavsjpbgdgg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFyemFoamF5eHZhdnNqcGJnZGdnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjE4OTQ4NDAsImV4cCI6MjAzNzQ3MDg0MH0.K8UcLM-pyT55xfjBcshjiXaAQgr_6BvZ6yibR1Hp9jU',
  );

  runApp(
    AppBuild(
      navigatorKey: NyNavigator.instance.router.navigatorKey,
      onGenerateRoute: nylo.router!.generator(),
      debugShowCheckedModeBanner: false,
      initialRoute: nylo.getInitialRoute(),
      navigatorObservers: nylo.getNavigatorObservers(),
    ),
  );
}
